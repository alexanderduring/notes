How to change the bash prompt to reflect the status of your repository
======================================================================

The standard prompt is like this:

    user@machine:/path/to/repo$

The goal is to have this, if you are on master and have no changes in your working copy

    user@machine:/path/to/repo (master)$

And this, if there are uncommitted changes

    user@machine:/path/to/repo (master±)$

Changes to .bashrc
------------------

The following three function definitions have to be added to the .basrc:

    # git
    parse_git_branch() {
      local BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
      echo -e "${BRANCH}"
    }

This defines a function *parse_git_branch()*, which takes a list of all git branches (git branch), removes every line that does not start with an "\*" (sed -e '/^[^\*]/d') and then takes everything that is after "* " and saves it in $BRANCH. 


    # git
    parse_git_status() {
      local STATUS=`git status --porcelain 2>&1`
      if [[ "$STATUS" != *'Not a git repository'* ]]; then
        if [[ "$STATUS" == '' ]]; then
          echo -e ''
        else
          echo -e '±'
        fi
      fi
    }

This defines a function *parse_git_status*. It fetches the output of *git status* and looks for the text part *"working directory clean"*. If it finds it, an empty string is returned, if not the "±" sign.

    # git
    git_prompt() {
      local BRANCH=$(parse_git_branch)
      local STATUS=$(parse_git_status)
      if [[ "$BRANCH" != '' ]]; then 
        echo -e " (${BRANCH}${STATUS})"
      fi
    }

The third function combines both return values to the text that is added to the prompt. For this text to apear in the prompt a last change has to be made in th e.bashrc. Look for the line, where the prompt is defined. On debian it should look like this

    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

Now add the *git_promp* function like this

    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(git_prompt)\$ '

Finished!
