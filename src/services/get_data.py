#!/usr/bin/env python
 
from pathlib import Path

import numpy as np
import pandas as pd
from sklearn.datasets import load_iris

import constants

CHANNEL_NAME = 'training'
TRAINING_PATH = constants.INPUT_PATH / CHANNEL_NAME

if __name__=="__main__":

    print([i for i in constants.PREFIX.glob("*")])
    iris = load_iris()
    df = pd.DataFrame(data= np.c_[iris['data'], iris['target']],
        columns= iris['feature_names'] + ['target'])
    df.to_csv( TRAINING_PATH / 'data.csv')