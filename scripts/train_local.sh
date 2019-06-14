#!/bin/sh

image=$1

mkdir -p test_dir/model
mkdir -p test_dir/output
mkdir -p test_dir/input/data/training/

sudo docker run -v $(pwd)/test_dir:/opt/ml --rm ${image} task

