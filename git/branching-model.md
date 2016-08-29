
Git Branching Model Reference Card
==================================

Main branches
-------------

  - master
  - develop

We consider 
  - origin/master to be the main branch where the source code of HEAD always reflects a production-ready state.
  - origin/develop to be the main branch where the source code of HEAD always reflects a state with the latest delivered development changes for the next release. Some would call this the “integration branch”. This is where any automatic nightly builds are built from.


Supporting branches
-------------------

  - Feature branches
  - Release branches
  - Hotfix branches


Feature branches
----------------

  - May branch off from `develop`
  - Must merge back into `develop`
  - Branch naming convention: anything except `master`, `develop`, `release-*` or `hotfix-*`


Release branches
----------------

  - May branch off from `develop`
  - Must merge back into `develop` and `master`
  - Branch naming convention: `^release-[0-9]*\.[0-9]*\.[0-9]*$`

### Creating a release branch ###

    $ git checkout -b release-1.2.0 develop

To set up the upstream branch use this:

    $ git push -u origin release-1.2.0

This creates a remote branch with the same name and connects it to your local branch for easy pushing / pulling.

### Finishing a release branch ###

First the release branch is merged back into `master` and tagged for deployment.

    $ git checkout master
    $ git merge --no-ff release-1.2.0
    $ git tag -a v1.2.0 -m "Created tag v1.2.0"
    $ git push origin v1.2.0

Second the changes made on the release branch need to be merged back into `develop`.

    $ git checkout develop
    
    $ git merge --no-ff release-1.2.0

Now the release branch should be removed. First the local one:

    $ git branch -d release-1.2.0

And now the remote branch:

    $ git push origin :release-1.2.0
