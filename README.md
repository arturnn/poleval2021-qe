# Submission to PolEval 2021 - Task 2: Evaluation of translation quality assessment metrics

This repository is split into blind and nonblind parts, as was the task itself.

## Requirements

Install requirements specified in the `requirements.txt` file:

`pip install -r requirements.txt`

## Models downloading

In order to download trained models, run `download_models.sh` script.

## Nonblind submission

To use an already trained model, run the following command from the `nonblind/model` directory:

`python3 score.py --model checkpoint/model.ckpt --test <path-to-test-file>`

To train the model yourself, run `train.sh` script from the `nonblind/train` directory.

## Blind submission

To use an already trained model, run the following command from the `blind/model` directory:

`python3 score.py --model checkpoint/model.ckpt --test <path-to-test-file>`

Scoring scripts expects TSV file input with 2 columns: machine translation in Polish (can be produced by `blind/model/backtranslate.py` script) and source sentence in English.

To train the model yourself, run `train.sh` script from the `nonblind/train` directory.

The training script uses already created dataset splits. To create them yourself, use `create_datasets.sh` script. This script may run a while, as it needs to translate input data back into English.
