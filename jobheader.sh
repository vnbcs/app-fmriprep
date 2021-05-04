#!/bin/bash

if [ "$(jq .large -r config.json)" == "true" ]; then
    echo "#PBS -l nodes=1:ppn=8,walltime=9:00:00,vmem=28gb"
else
    echo "#PBS -l nodes=1:ppn=8,walltime=9:00:00,vmem=14gb"
fi
