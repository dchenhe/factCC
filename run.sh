#! /bin/bash
# Evaluate FactCC model
export CUDA_VISIBLE_DEVICES=$1
# UPDATE PATHS BEFORE RUNNING SCRIPT
export CODE_PATH=./model # absolute path to modeling directory
export DATA_PATH=./paired_data # absolute path to data directory
export CKPT_PATH=./factcc-checkpoint # absolute path to model checkpoint
export MODEL_TYPE=bert
export TASK_NAME=factcc_annotated
export MODEL_NAME=bert-base-uncased
export SUM=$2
export SRC=$3 

python3 ./pair_data.py \
  --summary $SUM \
  --source $SRC

python3 $CODE_PATH/run.py \
  --task_name $TASK_NAME \
  --do_test \
  --eval_all_checkpoints \
  --do_lower_case \
  --overwrite_cache \
  --max_seq_length 512 \
  --per_gpu_train_batch_size 12 \
  --model_type $MODEL_TYPE \
  --model_name_or_path $MODEL_NAME \
  --data_dir $DATA_PATH \
  --output_dir $CKPT_PATH \
  --output-file output.jsonl

rm ./paired_data/cached_dev_bert-base-uncased_512_factcc_annotated
cat output.jsonl