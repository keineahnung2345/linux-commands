# Git commands
Make sure you are in the directory of the cloned repository!

## Get current branch name
`$git branch`

## Create a branch

`$git checkout master` Make sure you are in master branch every time you create a branch!!

`$git checkout -b <branch-name>` -b for create

`$git push origin <branch-name>` Push the branch from local to remote

## Switch to another branch
`$git checkout <branch-name>`

## Delete a branch
```sh
$git checkout master
$git branch -d <branch-name>
$git push origin :<branch-name>
```

## Fork and then create a pull request
Follow the instructions here: https://help.github.com/articles/creating-a-pull-request-from-a-fork/

## Add folders or files, commit, and then push(Git doesn't allow you to commit empty folders, the workaround is to add .gitkeep file into them)
```sh
$git add <folder-or-file-name>
$git commit
$git push origin <branch-name>
```

## Reset your forked repository
```sh
$git remote add upstream <the-url-of-upstream-repo>
$git fetch upstream
$git checkout master
$git reset --hard upstream/master
$git push origin master --force
```

## Sync your forked repository
```sh
$git remote add upstream <the-url-of-upstream-repo>
$git fetch upstream
$git checkout master
$git merge upstream/master
$git push origin master
```

## Sync a branch with master branch
```sh
$git pull origin <branch-name>
$git checkout <branch-name>
$git merge master
$git push origin <branch-name>
```

## Revert a commit
`$git revert <sha-of-a-commit>`

## Compare two branches
`$git diff <branch-name1>...<branch-name2>`
