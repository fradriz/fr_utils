# If I want to push some modifications into a critial branch (like develop) - NO PUSH TO MASTER !!
# 1) go to branch you are working
git branch --show-current
git checkout PAN-1680

# 2) Merge critical branch (like master) into the current branch
git pull origin master
# If any, conflicts will be listed here and point the problems in the files !!
echo before comment
: <<'END'
  $ git pull origin master
  From ssh://git-codecommit.us-east-2.amazonaws.com/v1/repos/data-engineering-utils
   * branch            master     -> FETCH_HEAD
  Auto-merging datautils/utils/bootstrap_datautils_spineds.sh
  CONFLICT (content): Merge conflict in datautils/utils/bootstrap_datautils_spineds.sh
  Auto-merging datautils/ais/idmap.py
  CONFLICT (content): Merge conflict in datautils/ais/idmap.py
  Automatic merge failed; fix conflicts and then commit the result.
END
echo after comment

git status
# Then I can push to 'PAN-2612b' branch
git push origin PAN-2612b

# Pull from the current branch
git pull

# Crear una nueva BRANCH
git checkout -b PAN-1680

git commit -m "mensaje"

# Push la nueva BRANCH
echo before comment
: <<'END'
  $ git push --set-upstream origin PAN-1680
  Total 0 (delta 0), reused 0 (delta 0)
  To ssh://git-codecommit.us-east-2.amazonaws.com/v1/repos/data_eng-aisd
  * [new branch] PAN-1680 -> PAN-1680
  Branch 'PAN-1680' set up to track remote branch 'PAN-1680' from 'origin'.
END
echo after comment


