from transformers import MarianMTModel, MarianTokenizer
import sys

if __name__ == '__main__':
    model_name = 'Helsinki-NLP/opus-mt-pl-en'
    tokenizer = MarianTokenizer.from_pretrained(model_name)
    model = MarianMTModel.from_pretrained(model_name).to('cuda:0')
    for line in sys.stdin:
        translated = model.generate(**tokenizer([line.strip()], return_tensors="pt", padding=True).to('cuda:0'))
        tgt_text = [tokenizer.decode(t, skip_special_tokens=True) for t in translated]
        print(tgt_text[0])
