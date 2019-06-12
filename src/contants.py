from pathlib import Path
from os import environ


# These are the paths to where SageMaker mounts interesting things in your container.
PREFIX = Path(environ["ML_PREFIX"])

INPUT_PATH = PREFIX / 'input/data'
OUTPUT_PATH = PREFIX / 'output'
MODEL_PATH = PREFIX / 'model'
PARAM_PATH = PREFIX / 'input/config/hyperparameters.json'

INPUT_COLUMNS = ['fk_customer', 'sale_order_store_date', 'sale_order_store_number', 'gmv']


LABEL_INDEX = {'Setosa' : 0, 'Versicolor' : 1, 'Virginica': 2}
LABEL_COLUMN = ["variety"]
ID_COLUMN = ["id"]
NUMERIC_FEATURES = ['sepal.length', 'sepal.width', 'petal.length', 'petal.width']
COLUMN_NAMES = ID_COLUMN + NUMERIC_FEATURES + LABEL_COLUMN