#!/usr/bin/env python
 
from pathlib import Path

import numpy as np
import pandas as pd
from sklearn.datasets import load_iris

import constants
from logger import set_up_logging


logger = set_up_logging(__name__)
CHANNEL_NAME = 'training'
TRAINING_PATH = constants.INPUT_PATH / CHANNEL_NAME

if __name__=="__main__":

    print([i for i in constants.PREFIX.glob("*")])
    if (TRAINING_PATH / 'data.csv').exists():
        file_path = str(TRAINING_PATH / 'data.csv')
        logger.info(f"Data already local at: {file_path}")
    else:
        file_path = str(TRAINING_PATH / 'data.csv')
        logger.info(f"Data already local at: {file_path}")
        iris = load_iris()
        df = pd.DataFrame(data= np.c_[iris['data'], iris['target']],
            columns= iris['feature_names'] + ['target'])
        df.to_csv(file_path)