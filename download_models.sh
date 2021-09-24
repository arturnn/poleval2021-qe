#!/bin/bash

set -e

NONBLIND_MODEL_URL=https://huggingface.co/anowakowski/poleval2021-qe-nonblind/resolve/main/model.tar.gz
BLIND_MODEL_URL=https://huggingface.co/anowakowski/poleval2021-qe-blind/resolve/main/model.tar.gz

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd nonblind/model && wget $NONBLIND_MODEL_URL && tar xf model.tar.gz && rm -rf model.tar.gz && cd $SCRIPT_DIR
cd blind/model && wget $BLIND_MODEL_URL && tar xf model.tar.gz && rm -rf model.tar.gz && cd $SCRIPT_DIR

