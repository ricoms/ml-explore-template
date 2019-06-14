from pathlib import Path
from os import environ


# These are the paths to where SageMaker mounts interesting things in your container.
PREFIX = Path(environ["ML_PREFIX"])

INPUT_PATH = PREFIX / 'input/data'
OUTPUT_PATH = PREFIX / 'output'
MODEL_PATH = PREFIX / 'model'
PARAM_PATH = PREFIX / 'input/config/hyperparameters.json'

BUCKET = 'ml-explore-template'
LABEL_INDEX = {'Setosa' : 0, 'Versicolor' : 1, 'Virginica': 2}
LABEL_COLUMN = ["variety"]
ID_COLUMN = ["id"]
NUMERIC_FEATURES = ['sepal length (cm)','sepal width (cm)','petal length (cm)','petal width (cm)']
COLUMN_NAMES = ID_COLUMN + NUMERIC_FEATURES + LABEL_COLUMN