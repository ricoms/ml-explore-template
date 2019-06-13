from sklearn.datasets import load_iris
import numpy as np
import pandas as pd
from pathlib import Path

iris = load_iris()

pd.DataFrame(data= np.c_[iris['data'], iris['target']],
columns= iris['feature_names'] + ['target']).to_csv(
    Path(__file__).parents[0] / 'data.csv')