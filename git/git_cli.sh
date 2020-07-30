# Update/List remote branches (git branch --help)
git branch --show-current

# cd to root directory:
git remote update origin --prune
# List branches
git branch -a

# Checkout to desire branch
git checkout BRANCH

# Change things in project and then ..
# Commit and push:
git commit -a -m "Fixing 1000 listing files limitation"
# Push to the branch
git push origin BRANCH

# ---------------------------------------
# Differences between branches
git diff BRANCH-01..BRANCH-02
# ---------------------------------------

# list local and remote branches by last commit order DESC (order asc "--sort=committerdate")
# Day || Author || Branch: PAN-2475e || Subject (message) || How much tieme ago ?
git branch -a --sort=-committerdate --format='%(committerdate:short) || %(color:white)%(authorname) %(color:reset) || %(refname:short) || %(color:red)%(contents:subject)%(color:reset) (%(color:white)%(committerdate:relative)%(color:reset))' |head -n 20
# Others
git branch -a --sort=-committerdate --format='%(committerdate:short) %(authorname) %(refname:short)'
git for-each-ref --count=30 --sort=-committerdate --format='%(committerdate:short) %(authorname) %(refname:short)'


# list local branches by last commit order DESC
git branch --sort=-committerdate --format='%(committerdate:short) || %(color:white)%(authorname) %(color:reset) || %(refname:short) || %(color:red)%(contents:subject)%(color:reset) (%(color:white)%(committerdate:relative)%(color:reset))'
git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(authorname) %(refname:short)'

git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'


# List Pull Requests - https://git-scm.com/docs/git-pull
git pull