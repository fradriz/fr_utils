# 1) Make the changes in the project
#   (ie delete some files or take out files from the project without actually delete the files 'git rm -cached -r .idea')
#   git rm can use wildcards like: 'git rm -rf /<path>/__pycache__/*'

# 2) Add the changes to the project (this is very important !)
git add .

# 3) Commit
git commit -m 'Removing __pycache2__'

# 4) push changes to a new branch .. since the branch doesn't exists, this will return an error
git push origin PAN-2391b

# 4.1) First checkout to the new branch localy.
git checkout -b PAN-2391d

# 4.2) Now push it to the new branch (it will create )
git push origin PAN-2391d