#!/bin/bash


builddir=$PWD
mkdir $builddir/artifacts &>/dev/null

#export ZEPHYR_SDK_INSTALL_DIR=/home/saiba/zephyr-sdk-0.16.9
export ZEPHYR_TOOLCHAIN_VARIANT="zephyr"
source venv/bin/activate
cd zmk/app


targets=(charybdis3m_left charybdis3m_right settings_reset)

	echo $target; 
	echo $PWD
	mkdir -p ./build/$target &>/dev/null
#	west boards
	 west build -p -b nice_nano//zmk -d /tmp/zmk-test -- -DCMAKE_MESSAGE_LOG_LEVEL=DEBUG
	#west build -p -b nice_nano -d $builddir/build/$target -- -DSHIELD=$target -DZMK_CONFIG=../../config  -DEXTRA_ZEPHYR_MODULES=/home/saiba/src/zmk-config-charybdis3m/modules/zmk-keyboard-charybdis3m
