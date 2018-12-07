# Git commands
Make sure you are in the directory of the cloned repository!

## Clone a repository
https://stackoverflow.com/questions/67699/how-to-clone-all-remote-branches-in-git

`$git clone https://github.com/<user-name>/<repo-name>.git`

If you want to clone all branches, it already does it for you.
You can check it with:

`git branch -a`

And to start work on one branch, just:

`git checkout <branch-name>`

## List all branch and get current branch name
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

## List commits of a branch since its creation from `master`
```sh
git log master...<branch-name>
```

## Just clone a branch of a repo
```sh
$git clone -b <branch-name> https://github.com/<user-name>/<repo-name>.git
```

## Fork and then create a pull request
Follow the instructions here: https://help.github.com/articles/creating-a-pull-request-from-a-fork/

## Add folders or files, commit, and then push(Git doesn't allow you to commit empty folders, the workaround is to add .gitkeep file into them)
```sh
$git add <folder-or-file-name>
$git commit
$git push origin <branch-name>
```

## Reset your \<branch-name> in forked repository
```sh
$git remote add upstream <the-url-of-upstream-repo>
$git fetch upstream
$git checkout <branch-name>
$git reset --hard upstream/master
$git push origin <branch-name> --force #--force solves non-fast-forward error
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

## Merge a local branch \<branch-feature> into another local branch \<branch-base>
```sh
$git checkout <branch-base>
$git merge <branch-feature>
$git push origin <branch-base>
```
If met with the problem `merge: <branch-feature> - not something we can merge`, try `$git checkout <branch-feature>` and then repeat the commands above.

## Rebase a branch to origin
```sh
$git fetch
$git rebase master
$git pull origin <branch-name> # to solve non-fast-forward error
$git push origin <branch-name>
```

## Import a repository(This is a hack to fork a repo but detach their dependency)
```
Click on the '+' sign on the upper right corner of Github webpage(next to your avatar)
Click on "Import repository"
In "Your old repository’s clone URL", paste the url of repo you want to import
Give it a new name and click "Begin import"
After the process is done, Github will send you a email confirming with that
```

## Revert a commit
(This will create a new commit)
`$git revert <sha-of-a-commit>`

## Revert multiple commits to a specific point
(This won't create new commit, it just remove the specific commits)
```sh
$git checkout <branch-name>
$git reset --hard <sha-of-a-commit>
$git push origin <branch-name> --force
```

## Compare two branches
`$git diff <branch-name1>...<branch-name2>`
