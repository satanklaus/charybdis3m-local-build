# PREREQUIREMENTS

    * zephyr sdk 0.16.9
    * zmk v0.3-184-g268b1b1e

# INSTALLATION

    * #export ZEPHYR_SDK_INSTALL_DIR=/home/saiba/zephyr-sdk-0.16.9
    * export ZEPHYR_TOOLCHAIN_VARIANT="zephyr"
    * clone repo: git clone https://github.com/satanklaus/zmk-config-charybdis3m
    * cd zmk-config-charybdis3m
    * create venv: python -m venv venv
    * activate: sourve venv/bin/activate
    * install west (build application): pip install west
    * init zephyr: west init -l config
    * west update
    * pip install -r zephyr/scripts/requirements.txt
    * cd zmk/app
    * west build -p -b nice_nano_v2 -- -DSHIELD=charybdis3m_right -DZMK_CONFIG=../../config
    * west build -p -b nice_nano_v2 -- -DSHIELD=charybdis3m_left -DZMK_CONFIG=../../config

# TODO
    * SDK install guide
    * freeze versions
