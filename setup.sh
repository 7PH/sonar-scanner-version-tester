#!/bin/bash

if [ ! -f ".env" ]; then
    cp .env.template .env
fi

if [ ! -f "prepare.sh" ]; then
    cp prepare.sh.template prepare.sh
fi

if [ ! -f "sonar-project.properties" ]; then
    cp sonar-project.properties.template sonar-project.properties
fi

if [ ! -d "src" ]; then
    mkdir src
    echo 'console.log("Hello World")' > src/index.js
fi
