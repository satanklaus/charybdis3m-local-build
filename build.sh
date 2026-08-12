#!/bin/bash


builddir=$PWD
mkdir $builddir/artifacts &>/dev/null

#export ZEPHYR_SDK_INSTALL_DIR=/home/saiba/zephyr-sdk-0.16.9
export ZEPHYR_TOOLCHAIN_VARIANT="zephyr"
source venv/bin/activate
cd zmk/app


targets=(charybdis3m_left charybdis3m_right settings_reset)

for target in ${targets[*]}; do 
	echo $target; 
	echo $PWD
	mkdir -p ./build/$target &>/dev/null
	west build -p -b nice_nano//zmk -d $builddir/build/$target -- -DSHIELD=$target -DZMK_CONFIG=../../config  -DEXTRA_ZEPHYR_MODULES=/home/saiba/src/zmk-config-charybdis3m/modules/zmk-keyboard-charybdis3m
	echo 	BUILD STATUS: $?
	cp $builddir/build/$target/zephyr/zmk.uf2 $builddir/artifacts/$target.uf2
done
