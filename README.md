SDK install
ZMK clean build
ZMK clean charybdis3m build
```bash
export ZEPHYR_TOOLCHAIN_VARIANT="zephyr"
```

# reinstall bootloader
If your device won't detect as keyboard anymore, but can be booted in DFU mode you should reset bootloader
```bash
#use venv!
pip install adafruit-nrfutil
# flash bootloader
# replace serial port name and bootloader filename
adafruit-nrfutil --verbose dfu serial --package nice_nano_bootloader-0.6.0_s140_6.1.1.zip -p /dev/ttyACM0 -b 115200 --singlebank --touch 1200
#sometimes you need to flash an old verified firmware to device appear again as keyboard
```
