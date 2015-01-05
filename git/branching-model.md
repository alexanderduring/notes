
Git Branching Model Reference Card
==================================

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

Now the release branch should be removed.

    $ git branch -d release-1.2.0

