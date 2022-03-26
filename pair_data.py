import argparse
import json
import os

from tqdm import tqdm


def main(args):
    paired_data = []
    sum = []
    src = []
    with open(args.summary) as fd:
        sum = [line for line in fd]

    with open(args.source) as fd:
        src = [line for line in fd]

    for id in range(len(sum)):
        cur = {}
        cur["id"] = id
        cur["text"] = src[id].split("</s>")[1].lower()
        cur["claim"] = sum[id].lower()
        cur["label"] = "CORRECT"
        paired_data.append(cur)

    path = "./paired_data/data-dev" +".jsonl"
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path,"w") as fd:
        for data in paired_data:
            fd.write(json.dumps(data, ensure_ascii=False)+"\n")


if __name__ == "__main__":
    PARSER = argparse.ArgumentParser()
    PARSER.add_argument("--summary", type=str, help="Path to directory holding summary")
    PARSER.add_argument("--source", type=str, help="Path to directory holding sourcedocument")
    ARGS = PARSER.parse_args()
    main(ARGS)