
Git Cheat Sheet
===============

Branches
--------

Show local branches:

    $ git branch

Show remote branches:

    $ git branch -r

Show information about connection between branches and remote branches:

    $ git branch -vv 
    
    * develop 834532 [origin/develop] Committed something on develop.
      master  5426d4 [origin/master] Message of last commit on master.

Update your local knowledge about remote branches:

    $ git remote update origin

Update and remove all references to remote branches that do not exist anymore:

    $ git remote update --prune origin


Deleting a remote branch:

    $ git push origin :<remote-branch>


Reverting Commits
-----------------

If you want to revert changes to a file in a commit that was already pushed you can checkout the old version of that file and commit it again.

    $ git checkout <commit_hash> -- path/to/file.txt


Renaming Branches
-----------------

Renaming a local branch is easy.

    $ git branch -m old-local-branch new-local-branch

Renaming the corresponding remote branch is possible via deleting the old remote branch and recreating a new remote branch from your local branch.


First delete the old remote branch:

    $ git push origin :old-remote-branch

Now recreate the remote branch with the new name:

    $ git push -u origin new-local-branch