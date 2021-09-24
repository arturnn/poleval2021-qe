#!/bin/bash
set -e 

# Create train and dev set
mkdir -p data/temp

git clone https://github.com/poleval/2021-quality-estimation-nonblind.git data/temp/2021-quality-estimation-nonblind

echo -e "mt\tsrc\tref\tscore" > data/train.tsv
echo -e "mt\tsrc\tref\tscore" > data/dev.tsv
paste data/temp/2021-quality-estimation-nonblind/test-A/in.tsv data/temp/2021-quality-estimation-nonblind/test-A/expected.tsv >> data/train.tsv
paste data/temp/2021-quality-estimation-nonblind/dev-0/in.tsv data/temp/2021-quality-estimation-nonblind/dev-0/expected.tsv >> data/dev.tsv
python3 utils/tsv2csv.py < data/train.tsv > data/train.csv
python3 utils/tsv2csv.py < data/dev.tsv > data/dev.csv

rm -rf data/temp data/*.tsv

# Train model
comet-train --cfg configs/train_regression_metric.yaml
