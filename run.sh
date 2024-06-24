#!/bin/bash

cp sonar-project.properties prepare.sh src/

cd src

# Run prepare.sh if it exists
if [ -f "prepare.sh" ]; then
    chmod +x prepare.sh
    ./prepare.sh
fi

# Run scanner
sonar-scanner \
    -Dsonar.organization=$SONAR_ORGANIZATION \
    -Dsonar.projectKey=$SONAR_PROJECT_KEY
