#!/bin/bash

# Use system params and create/save a json file with them
PROJECT_NAME=${PROJECT_NAME}
ACTIVITY_NAME=${ACTIVITY_NAME}
RESOURCE_NAME=${RESOURCE_NAME}

JSON_FMT='{"project_name":"%s","activity_name":"%s","resource_name":"%s"}\n'
printf "$JSON_FMT" "$PROJECT_NAME" "$ACTIVITY_NAME" "$RESOURCE_NAME" > /tmp/gdm_params.json
cat /tmp/gdm_params.json