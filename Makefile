
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

train-local: build-image
	git checkout $(uuidgen) && \
	docker run -v ${PWD}/test_dir:/opt/ml --rm ${NAME} task && \
	git add . && \
	git commit -m "new training job results"

get-data: build-image
	docker run -v ${PWD}/test_dir:/opt/ml --rm ${NAME} python services/get_data.py

test:
	echo ${PWD}