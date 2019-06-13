#!/bin/sh

image=$1

mkdir -p test_dir/model
mkdir -p test_dir/output
mkdir -p test_dir/input/data/training/

rm -f test_dir/model/*
rm -f test_dir/output/*

sudo docker run -v $(pwd)/test_dir:/opt/ml --rm ${image} task

rm -rf test_dir/input