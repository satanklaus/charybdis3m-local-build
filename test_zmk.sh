#!/bin/bash


builddir=$PWD
mkdir $builddir/artifacts &>/dev/null

export ZEPHYR_TOOLCHAIN_VARIANT="zephyr"
source venv/bin/activate
cd zmk/app


targets=(settings_reset)

for target in ${targets[*]}; do 
	echo --------------------------------$target; 
	echo $PWD
	mkdir -p ./build/$target &>/dev/null
	west build -p -b nice_nano//zmk -d $builddir/build/$target -- -DSHIELD=$target
	echo 	BUILD STATUS: $?
	cp $builddir/build/$target/zephyr/zmk.uf2 $builddir/artifacts/$target.uf2
done
