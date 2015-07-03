
Deleting Orphaned Branches
==========================

Sometimes you have a feature branch that was finished and merged into the develop branch, but was never deleted. The same could happen with a release branch that was merged into master and deployed, but is still around cluttering up the branches list. To find those branches you should first update your references and remove all references to remote branches that do not exist anymore:

    $ git remote update --prune origin


Finding Orphaned Branches
-------------------------

To list all local branches that are fully contained in the branch that you have currently checked out:

    $ git branch --merged

The same can be achieved for remote branches:

    $ git branch -r --merged


Deleting a Branch
-----------------

To delete the local branch:

    $ git branch -d <local-branch>

To delete the remote branch:

    $ git push origin :<remote-branch>
