# PREREQUIREMENTS

    * zephyr sdk 0.17.0 (registered via `west zephyr-export` / cmake package registry,
      or set ZEPHYR_SDK_INSTALL_DIR)

# INSTALLATION
    * git clone -b 3m https://github.com/satanklaus/charybdis3m-local-build.git
    * cd charybdis3m-local-build
    * git submodule update --init --recursive
    * ./prepare.sh
    * ./build.sh

# BUILDING

    * ./build.sh                           all targets -> artifacts/*.uf2
    * ./build.sh charybdis3m_central       selected targets only
    * ./build.sh -c                        full (pristine) rebuild
    * ./build.sh --no-config               without zmk-config-charybdis3m
    * ./build.sh --stock settings_reset    plain ZMK, no extra modules
    * ./build.sh -h                        help

# TODO
    * SDK install guide
