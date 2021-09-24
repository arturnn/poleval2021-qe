import pandas as pd
import fire
import torch
from comet import load_from_checkpoint


def predict(model, test):
    data = pd.read_csv(test, sep="\t", names=['mt', 'src', 'ref']).to_dict('records')
    model = load_from_checkpoint(model)
    seg_scores, _ = model.predict(data, batch_size=8, gpus=1)
    for r, p in zip(data, seg_scores):
        if p > 5:
            print(100)
        elif p < 0:
            print(0)
        else:
            print(p * 20)

if __name__ == "__main__":
    fire.Fire(predict)



