#!/bin/bash

sleep $(($RANDOM % 30))

python3 -m pip install --user --upgrade pip setuptools wheel boto3 jupyter
# python3 -m pip uninstall repo3 --y

sudo yum -y install git-core

RETRIES=3
clone_repo()
{
  REPO=$1
  BRANCH=$2
  REPOS_URL="https://git-codecommit.us-east-2.amazonaws.com/v1/repos/"
  CMD="git clone $REPOS_URL$REPO --single-branch --branch $BRANCH"
  cd ~/
  # Executing and retrying three times if there is an error in cloning
  n=1
  until [ $n -ge $((RETRIES+1)) ]
  do
    date
    echo "Attempt number: $n"
    echo "$CMD"
    eval "$CMD"
    ERROR_CODE=$?
    if [ $ERROR_CODE -eq 0 ]
    then
      break # Success
    else
      echo "ERROR running: $CMD"
      if [ $n -eq $RETRIES ]
      then
        echo "Error Code: $ERROR_CODE - $RETRIES attemps - Can't run: $CMD"
        exit $ERROR_CODE        # exiting with error code <> 0
      fi
    fi

    sleep $((3**n))         # exponential back-off
    n=$((n+1))
  done
}
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true

clone_repo "repo1" master
clone_repo "repo2" development
clone_repo "repo3" master

# Need to install two repos
cd ~/repos/repo1/ && python3 -m pip install . --user
cd ~/repos/repo2/ && python3 -m pip install . --user
