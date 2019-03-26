---
description: 'Automate syncing of GitHub branches (e.g.: _dev_ -> _master_) and reduce the amount of required "manual" work.'
---
Author: Emiliano Suñé 

# Automate GitHub tasks using Jenkins

## Overview
Automate syncing of GitHub branches (e.g.: _dev_ -> _master_) and reduce the amount of required "manual" work.
Multiple ways (including the one explained in this wiki) of achieving this are listed [here](https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys). This particular combination was chosen because of its relative simplicity and quick setup.

## Requirements
To set-up the automated job we need:
* a running instance of Jenkins in OpenShift
* a private/public SSH key pair

## Initial Setup
1. Generate your SSH keys
2. Add the public key (in OpenSSH-compatible format) to your Git repo as a [deploy key](https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys).
3. Create a new [OpenShift source secret Secret](https://docs.openshift.com/container-platform/latest/dev_guide/secrets.html) containing the PRIVATE part of the key (in OpenSSH-compatible format).
The SSH key secret type can be used, however if more than one SSH key is necessary (e.g.: when syncing more than one repository) an opaque secret can be used instead: this will allow specifying a custom name for the key/value pair holding the private key part. In this case, the content of the secret will need to be base64-encoded ([base64encode.org](http://base64encode.org) can be used for this purpose).
4. Add the secret to your Jenkins application, and mount it to the following path: ```/var/lib/jenkins/.ssh```. This will create a file for each key contained in the secret: the content of each file will be the textual content of the secret (in our case, the private key).
5. Most of the work is done, now we need to create a freestyle Jenkins job to do the work for us (see next section for details).

## Jenkins job setup
The new Jenkins job (e.g.: **sync-git-master-branches**) can be triggered manually (as any other jenkins job), OR scheduled to run periodically. In the job configuration, under **Build Triggers**, check _Build Periodically_ and enter a cron-like pattern to schedule the execution (e.g.: ```H 22 * * 1-4``` to run Mon-Thu at ~10pm).

The **Build** step consists of one _shell script_, structured as follows:
```
# clean up workspace before starting
echo 'Cleaning up workspace...'
rm -rf $WORKSPACE/git-repo-name
echo 'Done!'

# prepare ssh keys for repo
cp -f ~/.ssh/secret-key-name /tmp
chmod 400 /tmp/secret-key-name

# This is only required when setting up the keys, should be removed/commented for production use
# echo 'Testing SSH Key'
# /usr/bin/ssh -i /tmp/secret-key-name -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no git@github.com | true

# Create a ssh wrapper script for 
echo 'ssh -i /tmp/secret-key-name -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $*' > /tmp/gitssh
chmod +x '/tmp/gitssh'

# The following flag can be set to add verbose outbut, useful for debugging
# export GIT_TRACE=1

# GIT_SSH for versions of Git < 2.3.0
export GIT_SSH='/tmp/gitssh'

# GIT_SSH_COMMAND for git 2.3.0+
#export GIT_SSH_COMMAND="/usr/bin/ssh -vvv -i /tmp/secret-key-name -o StrictHostKeyChecking=no"

# sync git-repo-name
echo 'Syncing git-repo-name...'
git clone git@github.com:github-org/git-repo-name.git
cd ./git-repo-name
git checkout master

# This will fast-forward dev -> master
if git merge --ff-only origin/dev; then
    echo "Merge successful"
    git push origin master
else
    echo "There was an error merging git-repo-name/dev into git-repo-name/master!"
fi
```

- Slack notifications can be set-up using the Slack plugin for Jenkins to notify the team of successful updates and/or errors.
- Rocket.Chat notifications can be set-up using the rocket.cat for Jenkins (https://github.com/BCDevOps/platform-services/blob/master/wiki/app_rocketchat.md).
