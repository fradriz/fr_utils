#!/bin/bash

export PYSPARK_PYTHON=/usr/bin/python3
export PYSPARK_DRIVER_PYTHON=/usr/bin/python3

mkdir ~/repos

clone_repo()
{
  REPO=$1
  BRANCH=$2
  REPOS_URL="https://git-codecommit.us-east-2.amazonaws.com/v1/repos/"
  CMD="git clone $REPOS_URL$REPO ~/repos/$REPO/ --single-branch --branch $BRANCH"
  cd ~/
  echo "$CMD"
  eval "$CMD"
}

# git clone https://git-codecommit.us-east-2.amazonaws.com/v1/repos/repo1 --single-branch --branch development
clone_repo "repo1" master
clone_repo "repo2" development
clone_repo "repo3" master

# Need to install two repos
cd ~/repos/repo1/ && python3 -m pip install . --user
cd ~/repos/repo2/ && python3 -m pip install . --user
