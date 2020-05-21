# Git commands
Make sure you are in the directory of the cloned repository!

Also make sure the cloned repository is yours!
If not, there will be an error message:

> $ git push origin \
remote: Permission to \<other-user-name>/\<repo-name>.git denied to \<your-name>. \
fatal: unable to access 'https://github.com/<other-user-name\>/\<repo-name>/': The requested URL returned error: 403

## Make a directory git repository
[A new repo from an existing project](https://kbroman.org/github_tutorial/pages/init.html)
```sh
$git init
$git add *
$git commit
```

## Clone a repository
https://stackoverflow.com/questions/67699/how-to-clone-all-remote-branches-in-git

`$git clone https://github.com/<user-name>/<repo-name>.git`

To clone into a specific directory:

`$git clone https://github.com/<user-name>/<repo-name>.git <directory>`

If you want to clone all branches, it already does it for you.
You can check it with:

`$git branch -a`

And to start work on one branch, just:

`$git checkout <branch-name>`

## list all remote version control base's name and website
```
$git remote -v
```

## Just clone a folder from a repository
[How do I clone a subdirectory only of a Git repository?](https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository)

```bash
$mkdir <repo>
$cd <repo>
$git init
$git remote add -f origin <url>
$git config core.sparseCheckout true
$echo "some/dir/" >> .git/info/sparse-checkout
$git pull origin master
```

## Just clone a branch of a repo
```sh
$git clone -b <branch-name> https://github.com/<user-name>/<repo-name>.git
```

## Synchronize(Reset) local repo with remote one
[git: sync local repo with remote one](https://stackoverflow.com/questions/6373277/git-sync-local-repo-with-remote-one)

```bash
git fetch --prune #-p, --prune: After fetching, remove any remote-tracking branches which no longer exist on the remote.
git checkout <branch-name> #if there are new branches
```

If the commands above do not work, try: 

```sh
git pull
```

Method 2:

[Reset local repository branch to be just like remote repository HEAD](https://stackoverflow.com/questions/1628088/reset-local-repository-branch-to-be-just-like-remote-repository-head)

```sh
git fetch origin
git reset --hard origin/master
git clean -n -f
```

## List all branch and get current branch name
`$git branch`

## List all remote branch
[How do I list all remote branches in Git 1.7+?](https://stackoverflow.com/questions/3471827/how-do-i-list-all-remote-branches-in-git-1-7)

`$git branch -r`

## Discard unstaged changes
[How do I discard unstaged changes in Git?](https://stackoverflow.com/questions/52704/how-do-i-discard-unstaged-changes-in-git)

`$git checkout -- .`

## Switch branch, discard all changes
[Error when changing to master branch: my local changes would be overwritten by checkout](https://stackoverflow.com/questions/22424142/error-when-changing-to-master-branch-my-local-changes-would-be-overwritten-by-c)

`$git checkout -f <branch-name>`

## Stash local changes(before switching to another branch)
[Stash暫存](https://kingofamani.gitbooks.io/git-teach/content/chapter_3_branch/stash.html)

```sh
# now we are on <original-branch-name>
git stash -u
# switch to <another-branch-name>
git checkout <another-branch-name>
# after the work is done on <another-branch-name>, change back to <original-branch-name>
# this is important!
# if you don't switch to <original-branch-name> first,
# the stashed changes will be applied to <another-branch-name>!!
git checkout <original-branch-name>
git stash list
git stash pop
```

## Create a branch

`$git checkout master` Make sure you are in master branch every time you create a branch!!

`$git checkout -b <branch-name>` -b for create

`$git push origin <branch-name>` Push the branch from local to remote

## Rename a branch
[How do I rename a local Git branch?](https://stackoverflow.com/questions/6591213/how-do-i-rename-a-local-git-branch)

```sh
$git branch -m <old-branch-name> <new-branch-name>
$git checkout <new-branch-name>
$git push origin :<old-branch-name>
$git push -u origin <new-branch-name>
```

## Switch to another branch
`$git checkout <branch-name>`

[Git: cannot checkout branch - error: pathspec '…' did not match any file(s) known to git](https://stackoverflow.com/questions/5989592/git-cannot-checkout-branch-error-pathspec-did-not-match-any-files-kn)

If there is an error: 

`error: pathspec 'xxx' did not match any file(s) known to git.`, 

one can use:

`$git fetch`

to make local repo updated with the remote one.

## Move uncommited work to another branch
[Move existing, uncommitted work to a new branch in Git](https://stackoverflow.com/questions/1394797/move-existing-uncommitted-work-to-a-new-branch-in-git)
```sh
git switch -c <new-branch-name>
```

## Delete a branch
```sh
$git checkout master
$git branch -d <branch-name>
$git push origin :<branch-name>
```

## Recover a deleted branch
[Can I recover a branch after its deletion in Git?](https://stackoverflow.com/questions/3640764/can-i-recover-a-branch-after-its-deletion-in-git)

```sh
# use this command to find the SHA1 for the commit at the tip of your deleted branch
git reflog
git checkout -b <deleted-branch-name> <sha>
```

## Copy files between branches
[How do I copy a version of a single file from one git branch to another?](https://stackoverflow.com/questions/307579/how-do-i-copy-a-version-of-a-single-file-from-one-git-branch-to-another)

```sh
git checkout <other-branch-name> <relative_path_to_file_or_dir>
```

## List commits of a branch since its creation from `master`
```sh
git log master...<branch-name>
```

## Fork and then create a pull request
Follow the instructions here: https://help.github.com/articles/creating-a-pull-request-from-a-fork/

## Apply unmerged pull request to own fork
[How to apply unmerged upstream pull requests from other forks into my fork?](https://stackoverflow.com/questions/6022302/how-to-apply-unmerged-upstream-pull-requests-from-other-forks-into-my-fork)
1. If you don't want it to be merged to your master branch, first create a new branch
2. Go to the webpage of the branch from other fork(which is the branch you want to apply)
3. Select `New Pull Request`
4. Choose the correct repo name and branch name
5. Click `Create Pull Request`
6. Merge the pull request

## Add folders or files, commit, and then push(Git doesn't allow you to commit empty folders, the workaround is to add .gitkeep file into them)
```sh
$git add <folder-or-file-name>
$git commit
$git push origin <branch-name>
```

[Changes not staged for commit even after git add](https://stackoverflow.com/questions/36291216/changes-not-staged-for-commit-even-after-git-add)

If got `Changes not staged for commit` even after using `git add`, one can try change to the specific folder and then use `git add` again.

## Sign off
First [set user name and email](https://github.com/keineahnung2345/linux-commands/blob/master/Git%20commands.md#set-user-name-and-email) and then:

```sh
git commit -s
```

## Revert `git add`
[How can you undo the last git add?](https://stackoverflow.com/questions/12132272/how-can-you-undo-the-last-git-add)
```sh
$git reset -- <folder-or-file-name>
$git reset #revert all added folders or files
```

## Add empty folders
[How can I add an empty directory to a Git repository?](https://stackoverflow.com/questions/115983/how-can-i-add-an-empty-directory-to-a-git-repository)

Just add `.gitignore` in that empty folder, so GitHub will keep it.

## Make .gitignore take effect
[.gitignore is ignored by Git](https://stackoverflow.com/questions/11451535/gitignore-is-ignored-by-git)

```sh
$git rm -r --cached .
$git add .
$git commit -m "fixed untracked files"
```

## Make git ignore lines matching specific patter
[How to tell git to ignore individual lines, i.e. gitignore for specific lines of code [duplicate]](https://stackoverflow.com/questions/16244969/how-to-tell-git-to-ignore-individual-lines-i-e-gitignore-for-specific-lines-of)

Create `<project root>/.git/info/attributes` and then add into the file:
```sh
*.cpp filter=gitignore
```

Use `git config` to define the filter named `gitignore`:

```sh
git config --global filter.gitignore.clean "sed  '/View.*\(.*\);/d'"
git config --global filter.gitignore.smudge cat
```

## Untrack files
[Untrack files from git temporarily](https://stackoverflow.com/questions/6964297/untrack-files-from-git-temporarily)
```sh
git rm -r --cached <folder-or-file-name>
```
Then you can see when using `git commit`, the file or folder moves from `Changes to be committed` part to `Untracked files` part.

## Unstage files
[Why are there two ways to unstage a file in Git?](https://stackoverflow.com/questions/6919121/why-are-there-two-ways-to-unstage-a-file-in-git)
```sh
git reset -- <filePath>
```
Then you can see when using `git commit`, the file or folder moves from `Changes to be committed` part to `Changes not staged for commit` part.

## Delete files and then commit
Ref : [Removing multiple files from a Git repo that have already been deleted from disk](https://stackoverflow.com/questions/492558/removing-multiple-files-from-a-git-repo-that-have-already-been-deleted-from-disk)
```sh
$git add -u :/
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

## Undo `git remote add upstream`
```sh
$git remote rm upstream
```

## `fatal: remote origin already exists.`
```sh
$git remote rm origin
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

## Pull a specific branch from remote to local
```sh
$git pull origin <branch-name>
```

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

## Restore a file to specific commit version
[How can I reset or revert a file to a specific revision?](https://stackoverflow.com/questions/215718/how-can-i-reset-or-revert-a-file-to-a-specific-revision)

```sh
git checkout <sha-of-a-commit> -- /file1/to/restore
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

Another method([How to remove commits from a pull request](https://stackoverflow.com/a/51400593/10651567)):
```sh
$git checkout <branch-name>
$git rebase -i HEAD~n # this will include `n` last commits in interactive rebase
# a nano editor will show up
# the work `pick` precedes every commit
# now replace `pick` with `drop`
# then write out(Ctrl+O) and exit(Ctrl+X)
$git push origin <branch-name> --force
```

## Compare two branches
```sh
$git diff <branch-name1> <branch-name2>
# specify the file to compare
$git diff <branch-name1> <branch-name2> <filename>
```

## Compare current state and last commit
[See diff between current state and last commit](https://stackoverflow.com/questions/17244471/see-diff-between-current-state-and-last-commit)
```sh
$git diff
```
or 

[Finding diff between current and last version
](https://stackoverflow.com/questions/9903541/finding-diff-between-current-and-last-version)

```sh
$git diff HEAD
```

[How to see the changes in a Git commit?](https://stackoverflow.com/questions/17563726/how-to-see-the-changes-in-a-git-commit)

```sh
$git show <sha-of-a-commit>
```

Only show the filenames([Can I make 'git diff' only show the changed file names and line numbers?](https://stackoverflow.com/questions/9848347/can-i-make-git-diff-only-show-the-changed-file-names-and-line-numbers)):
```sh
$git diff --name-only
```
Ignore a specific directory([Exclude a directory from git diff](https://stackoverflow.com/questions/4380945/exclude-a-directory-from-git-diff)):
```sh
$shopt -s extglob
$git diff !(<dir_name>)
```


## Check git branch graph
`$git log --oneline --graph`

To see log info of all branches:

`$git log --oneline --graph --branches`

## Compare commits
[Comparing commits](https://help.github.com/en/articles/comparing-commits-across-time#comparing-commits)

First find out the SHA codes of the two commits, and then open `https://github.com/<repo_owner>/<repo_name>/compare/<commit_sha1>..<commit_sha2>` in the browser.

## Get number of lines changed between two commits
[How can I calculate the number of lines changed between two commits in git?](https://stackoverflow.com/questions/2528111/how-can-i-calculate-the-number-of-lines-changed-between-two-commits-in-git/2528129)
```sh
$git log --stat
$git diff --shortstat <branch-name>
```

## Add equation into Github README.md
[How to show math equations in general github's markdown(not github's blog)](https://stackoverflow.com/questions/11256433/how-to-show-math-equations-in-general-githubs-markdownnot-githubs-blog)

Write your equation in [iTex2Img](http://www.sciweavers.org/free-online-latex-equation-editor), find its url, and then add the following into your README.md:
```
![equation](http://www.sciweavers.org/tex2img.php?<somewhere_link_to_your_image>)
```

## Add image into Github README.md
Add the following into your README.md:
```
![image](<image_url>)
```

To resize([Changing image size in Markdown](https://stackoverflow.com/questions/14675913/changing-image-size-in-markdown)):
```
<img src="<image_url>" alt="drawing" width="200"/>
```

## check git config
[Easiest way to reset git config file](https://stackoverflow.com/questions/35853986/easiest-way-to-reset-git-config-file)
```sh
# config only for this repo
# stored in <repo>/.git/config
git config --local --list
# global config
# stored in ~/.gitconfig
git config --global --list
```

## set user name and email
```sh
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

## set git proxy
[为 git bash 设置代理](https://jjayyyyyyy.github.io/2019/08/11/git_bash_proxy.html)
```sh
git config --global http.proxy "http://127.0.0.1:1080"
git config --global https.proxy "https://127.0.0.1:1080"
```

## unset git proxy
[Git: How to remove proxy](https://stackoverflow.com/questions/32268986/git-how-to-remove-proxy/32269086)
```sh
git config --global --unset https.proxy
git config --global --unset http.proxy
git config --unset http.proxy
git config --unset https.proxy
```

If it doesn't work, use:
```sh
git config --global --edit
```
and clean the field `proxy`, like:
```
[http]
[https]
[http "https://github.com"]
        proxy =
[https "https://github.com"]
        proxy =
```

## upload large file(> 100MB)
[Git Large File Storage](https://git-lfs.github.com/)

For installation, please check https://github.com/keineahnung2345/linux-commands/blob/master/Linux%20packages.md#git-lfs.

## fatal: The remote end hung up unexpectedly
[Git, fatal: The remote end hung up unexpectedly](https://stackoverflow.com/questions/15240815/git-fatal-the-remote-end-hung-up-unexpectedly)
```sh
git config --global http.postBuffer 524288000
```
