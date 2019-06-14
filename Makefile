
define get_version
	$(shell git rev-parse --verify HEAD | sed -r 's/(.{8}).*/\1/g')
endef

TAG = $(call get_version,)
# DOCKER_SERVER ?= "556684128444.dkr.ecr.us-east-1.amazonaws.com"

# REPOSITORY = ${DOCKER_SERVER}/${NAME}
PWD = $(shell pwd)
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
NAME = $(current_dir)


local-airflow-up:
	docker-compose up

local-airflow-down:
	docker-compose down

local-airflow-logs:
	docker-compose logs

build-image:
	docker build -t ${NAME} -f Dockerfile .

get-data: build-image
	dvc run \
		-o test_dir/input/data/training/data.csv \
		-d src/services/get_data.py \
		-f data.dvc \
		docker run -v ${PWD}/test_dir:/opt/ml --rm ${NAME} python services/get_data.py

train-local: build-image
	dvc run \
		-d test_dir/input/data/training/data.csv \
		-d test_dir/input/config/hyperparameters.json \
		-d src/task \
		-o test_dir/model/model.joblib \
		-M test_dir/output/metrics.json \
		-f train.dvc \
		docker run -v ${PWD}/test_dir:/opt/ml --rm ${NAME} task
