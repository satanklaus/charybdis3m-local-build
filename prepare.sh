#!/bin/bash

python -m venv venv
source venv/bin/activate
pip install west
west init -l config
west update
pip install -r zephyr/scripts/requirements.txt
