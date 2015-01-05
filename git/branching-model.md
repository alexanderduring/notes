
Git Branching Model Reference Card
==================================

Release branches
----------------

  - May branch off from `develop`
  - Must merge back into `develop` and `master`
  - Branch naming convention: `^release-[0-9]*\.[0-9]*\.[0-9]*$`

### Creating a release branch ###

    $ git checkout -b release-1.2.0 develop

### Finishing a release branch ###

First the release branch is merged back into `master` and tagged for deployment.

    $ git checkout master

    $ git merge --no-ff release-1.2.0

    $ git tag -a 1.2.0

Second the changes made on the release branch need to be merged back into `develop`.

    $ git checkout develop
    
    $ git merge --no-ff release-1.2.0

Now the release branch should be removed.

    $ git branch -d release-1.2.0

