#!/bin/bash

python -m venv venv
source venv/bin/activate
pip install west
cd zmk
west init -l app
west update
west packages pip --install
west zephyr-export
pip install -r zephyr/scripts/requirements.txt
