#!/bin/bash
# Build ZMK firmware for the Charybdis 3m. Firmware lands in artifacts/<target>.uf2.
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

all_targets=(charybdis3m_left charybdis3m_right settings_reset charybdis3m_central)
modules=(
	"$root/zmk-keyboard-charybdis3m"
	# "$root/zmk-behavior-pushbutton"  # enable once the module is finished
)
config="$root/zmk-config-charybdis3m"
pristine=auto
west_args=()
out=artifacts
build=build

usage() {
	cat <<EOF
Usage: $0 [options] [target...]

Targets (default: all): ${all_targets[*]}

Options:
  -c, --clean    full rebuild (west build -p always)
  --no-config    build without zmk-config-charybdis3m (stock keymap)
  --stock        plain ZMK: no extra modules, no config (e.g. settings_reset)
  -l, --usb-logging
                 log over USB serial (zmk-usb-logging snippet),
                 firmware goes to artifacts/usb-logging/
  -h, --help     show this help
EOF
}

targets=()
while (($#)); do
	case $1 in
		-c|--clean) pristine=always ;;
		--no-config) config= ;;
		--stock) config= modules=() ;;
		-l|--usb-logging) west_args+=(-S zmk-usb-logging) out=artifacts/usb-logging build=build/usb-logging ;;
		-h|--help) usage; exit 0 ;;
		-*) echo "unknown option: $1" >&2; usage >&2; exit 2 ;;
		*) targets+=("$1") ;;
	esac
	shift
done
((${#targets[@]})) || targets=("${all_targets[@]}")

cmake_args=()
if ((${#modules[@]})); then
	cmake_args+=("-DZMK_EXTRA_MODULES=$(IFS=';'; echo "${modules[*]}")")
fi
[[ -n $config ]] && cmake_args+=("-DZMK_CONFIG=$config")

export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
source "$root/venv/bin/activate"
cd "$root/zmk/app"
mkdir -p "$root/$out"

failed=()
for target in "${targets[@]}"; do
	echo "-------------------------------- $target"
	artifact="$root/$out/$target.uf2"
	rm -f "$artifact"
	if west build -p "$pristine" "${west_args[@]}" -b nice_nano//zmk -d "$root/$build/$target" -- \
		-DSHIELD="$target" "${cmake_args[@]}"; then
		cp "$root/$build/$target/zephyr/zmk.uf2" "$artifact"
	else
		failed+=("$target")
	fi
done

echo "--------------------------------"
for target in "${targets[@]}"; do
	if [[ " ${failed[*]} " == *" $target "* ]]; then
		echo "FAILED  $target"
	else
		echo "OK      $target -> $out/$target.uf2"
	fi
done
((${#failed[@]} == 0))
