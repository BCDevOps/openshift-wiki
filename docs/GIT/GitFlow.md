Angelikas-MacBook-Pro:docs aehlers$ vi GIT/GitFlow.md

## GitFlow

Two main branches:

* Master 

* Dev

The Master branch is the main branch of the project and will be in the ready-for-production state. They are on the remote repository (origin).
So, whenever you clone the repository on the Master branch, you will have the last stable version of the project, which is very important.

The develop branch reflects all the new features for the next release.
When the code inside the dev branch is stable (this means that you have done all changes for the next releases and tested it), you reach the stable point on the dev branch. Then, you can merge the dev branch into Master.

Feature branches

A feature branch is named based on what your feature is about and will exist as long as the feature is in development.
Feature branches only exist in local developer repositories; do not push them on the remote repository. When your feature is ready, you can merge your branch feature to develop and delete the branch. Execute the following steps:
1. Go back to the dev branch: $ git checkout dev
2. Merge the branch to dev by creating a new commit object: $ git merge --no-ff featureBranch
3. Delete the branch: $ git branch -d featureBranch
4. Push your changes on the remote dev repository:  $ git push origin dev

Hot-fix branches

These kinds of branches are very similar to release branches. It will respond to fixing a critical bug on production.
The goal is to quickly  x a bug while the other team members can work on their features. For example, your website is tagged as 1.1, and you are still developing the blog feature on the blog branch. You  nd a huge bug on the slider inside the main page, so you work on the release branch to  x it as soon as possible.
Create a hotfix branch named: $ git checkout -b hotfix-1.1.1 master
Fix the bug and merge it to master (after a commit, of course): 

```
$ git checkout master
$ git merge --no-ff hotfix-1.1.1
$ git tag -a 1.1.1
Similarly, like the release branch, merge the hot x branch into the current release branch (if it exists) or dev branch. Then delete it:
$ git checkout dev
$ git merge --no-ff hotfix-1.1.1
$ git branch -d hotfix-1.1.1
```

