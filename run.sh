#!/bin/bash

echo "====ACTIVATE CONDA ENVIRONMENT===="
source activate pytorch
echo "====RUN TRAIN.PY===="
python train_short_term.py
