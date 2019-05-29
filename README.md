# Spielebuch
[![Build Status](https://app.bitrise.io/app/a3630b2c59177ea1/status.svg?token=M338UjA3bQXJP8OlSNY_5w&branch=master)](https://app.bitrise.io/app/a3630b2c59177ea1) [![Mergify Enabled](https://gh.mergify.io/badges/bennokress/spielebuch.svg?style=flat)](https://mergify.io)

iOS app to save the results of board &amp; card games

# Development Notes
## xUnique
This project uses [xUnique](https://github.com/truebit/xUnique) to reduce merge conflicts with the Xcode project file. To automate the unification process all work is done in git hooks. Since hooks are not part of a git project, please add them manually:

Add a file `.git/hooks/pre-commit` containing:
```bash
#!/bin/sh

# Run xUnique --> https://github.com/truebit/xUnique
./Automation/pre-commit-xUnique
```

Add a file `.git/hooks/post-commit` containing:
```bash
#!/bin/sh

# Run xUnique --> https://github.com/truebit/xUnique
./Automation/post-commit-xUnique
```

Afterwards run `chmod +x` on both hooks to make them executable.

## Commit Message Prefix
This project requires a prefix on each commit message on feature branches matching the branch name. The convention is that branches are named "#XX_Y" with XX being the feature or bug identifier from the Github Issue Tracker, the Y is an optional keyword when the branch just handles a part of the issue (e.g. "#1_GameData" or just "#2"). The only exception is maintenance on the repo or tooling without an issue, which is done on a branch named "Maintenance". The following script can be used to automate the commit naming, if is put into `.git/hooks/prepare-commit-msg`:
```bash
#!/bin/sh

COMMIT_MSG=$1
COMMIT_MODE=$2

# Skip on master branch
if [ -z "$BRANCHES_TO_SKIP" ]; then
  BRANCHES_TO_SKIP=(master)
fi

# Convert '_' to ' '
BRANCH_NAME=$(git branch | grep '*' | sed 's/* //' | tr '_' ' ')

BRANCH_EXCLUDED=$(printf "%s\n" "${BRANCHES_TO_SKIP[@]}" | grep -c "^$BRANCH_NAME$")
BRANCH_IN_MESSAGE=$(grep -c "\[$BRANCH_NAME\]" $1)
BRACKETS_IN_MESSAGE=$(grep -c "\[.*\]" $1)
REBASING=$(echo $BRANCH_NAME | grep 'rebasing')

if [ -n "$BRANCH_NAME" ] && ! [[ $BRANCH_EXCLUDED -eq 1 ]] && ! [[ $BRANCH_IN_MESSAGE -ge 1 ]] && [ -z "$REBASING" ] && ! [[ $BRACKETS_IN_MESSAGE -ge 1 ]] ; then 

    # We check the fist line of the commit message file.
    # If it's an empty string then user didn't use `git commit --amend` so we can fill the commit msg file
    firstline=`head -n1 $COMMIT_MSG`

    if [ "$COMMIT_MODE" = "message" ] || [ -z "$firstline" ] ; then
        sed -i.bak -e "1s:^:[$BRANCH_NAME] :" $COMMIT_MSG
    fi

else

    if [ -z "$BRANCH_NAME" ]; then
        echo 'prepare-commit-msg: Empty branch name'
    fi

    if [ -n "$REBASING" ]; then
        echo 'prepare-commit-msg: Rebasing'
    fi

    if [[ $BRANCH_EXCLUDED -eq 1 ]]; then
        echo 'prepare-commit-msg: Branch excluded from commit message'
    fi

    if [[ $BRANCH_IN_MESSAGE -ge 1 ]]; then
        echo 'prepare-commit-msg: Branch already on commit message'
    fi
fi

if [ -z "$REBASING" ]; then
    # Add one blank line in second line if not exists
    firstline=`head -n1 $COMMIT_MSG`
    secondline=`head -n2 $COMMIT_MSG | tail -1`
    if [ -n "$firstline" ] && [ -n "$secondline" ] && ! [ "$firstline" == "$secondline" ]; then
        echo adding new line
        sed -i '1 a\\' $COMMIT_MSG
    fi
fi
```

