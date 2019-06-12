
define get_version
$(shell git rev-parse --verify HEAD | sed -r 's/(.{8}).*/\1/g')
endef

TAG = $(call get_version,)
# DOCKER_SERVER ?= "556684128444.dkr.ecr.us-east-1.amazonaws.com"
NAME = ml-explore-template
# REPOSITORY = ${DOCKER_SERVER}/${NAME}

pull-airflow:
	docker pull puckel/docker-airflow

raise-airflow: pull-airflow
	docker run -it -p 8080:8080 -v /dags/:/usr/local/airflow/dags --name web --rm puckel/docker-airflow webserver

build-image:
	docker build -t ${NAME}:${TAG} -f src/Dockerfile src/


