#!/bin/bash

cp sonar-project.properties src/

cd src

sonar-scanner \
    -Dsonar.organization=$SONAR_ORGANIZATION \
    -Dsonar.projectKey=$SONAR_PROJECT_KEY \
    -Dsonar.sources=.
