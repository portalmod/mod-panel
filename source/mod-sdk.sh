#!/bin/bash

set -e

cd $(dirname "${0}")/mod-sdk

# TODO setup MOD_DEVICE_MODE
# TODO setup MOD_DATA_DIR
# TODO setup LV2_PATH

# if coming through PawPaw, reset PATH
if [ -n "${OLD_PATH}" ]; then
    export PATH="${OLD_PATH}"
fi

# check for pip3 tool
if ! which pip3 1>/dev/null 2>/dev/null; then
    echo "pip3 tool not available, cannot continue"
    exit 1
fi

# install virtualenv as needed
if ! virtualenv --version 2>/dev/null; then
    pip3 install virtualenv
fi

# activate virtualenv
virtualenv modsdk-env
source modsdk-env/bin/activate

# install required mod-ui dependencies in virtualenv
pip3 install -r requirements.txt

# start mod-sdk inside virtualenv
exec python3 ./development_server.py
