#!/usr/bin/env bash

set -u

dirs='ls -d */ | sed "s#/\$##"'

for dir in dirs;do
    cd $dir
    kubectl create namespace $dir --dry-run -o yaml | kubectl apply -f -
    kubectl config set-context --current --namespace=$dir
    make install
    make test
    cd ..
done
