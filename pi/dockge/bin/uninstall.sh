#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $DIR
cd ..

docker compose down
