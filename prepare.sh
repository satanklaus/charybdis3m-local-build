#!/bin/bash
# Create the Python venv and the west workspace inside zmk/. Safe to re-run.
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$root"

[[ -d venv ]] || python -m venv venv
source venv/bin/activate
pip install 'west>=1.5,<2'

cd zmk
[[ -d .west ]] || west init -l app
west update --narrow -o=--depth=1
west zephyr-export
west packages pip --install
