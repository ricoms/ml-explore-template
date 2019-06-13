from sklearn.datasets import load_iris
import numpy as np
import pandas as pd

iris = load_iris()

pd.DataFrame(data= np.c_[iris['data'], iris['target']],
                     columns= iris['feature_names'] + ['target']).to_csv('data.csv')