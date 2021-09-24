#!/bin/bash

set -e

mkdir -p train-data/temp

git clone https://github.com/poleval/2021-quality-estimation-nonblind.git train-data/temp/2021-quality-estimation-nonblind
git clone https://github.com/poleval/2021-quality-estimation-blind.git train-data/temp/2021-quality-estimation-blind

cut -f1,2,4 <(cat \
    <(paste train-data/temp/2021-quality-estimation-nonblind/test-A/in.tsv train-data/temp/2021-quality-estimation-nonblind/test-A/expected.tsv) \
    <(paste train-data/temp/2021-quality-estimation-nonblind/dev-0/in.tsv train-data/temp/2021-quality-estimation-nonblind/dev-0/expected.tsv)) \
    > train-data/temp/nonblind-data.tsv

cat <(paste train-data/temp/2021-quality-estimation-blind/test-A/in.tsv train-data/temp/2021-quality-estimation-blind/test-A/expected.tsv) \
    <(paste train-data/temp/2021-quality-estimation-blind/dev-0/in.tsv train-data/temp/2021-quality-estimation-blind/dev-0/expected.tsv) \
    > train-data/temp/blind-data.raw.tsv

echo "Backtranslating data into English..."
cut -f1 train-data/temp/blind-data.raw.tsv | python3 utils/backtranslate.py > train-data/temp/blind-data.bt.tsv
paste <(cut -f1 train-data/temp/blind-data.raw.tsv) train-data/temp/blind-data.bt.tsv <(cut -f2 train-data/temp/blind-data.raw.tsv) > train-data/temp/blind-data.tsv

echo -e "mt\tsrc\tscore" > train-data/train.tsv
echo -e "mt\tsrc\tscore" > train-data/dev.tsv

head -100 train-data/temp/nonblind-data.tsv >> train-data/dev.tsv
tail -n +101 train-data/temp/nonblind-data.tsv >> train-data/train.tsv
cat train-data/temp/blind-data.tsv >> train-data/train.tsv

python3 utils/tsv2csv.py < train-data/dev.tsv > train-data/dev.csv
python3 utils/tsv2csv.py < train-data/train.tsv > train-data/train.csv

rm -rf train-data/temp train-data/*.tsv
