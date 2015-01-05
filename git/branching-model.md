
Git Reference Card
==================

Release branches
----------------

  - May branch off from `develop`
  - Must merge back into `develop` and `master`
  - Branch naming convention: `^release-[0-9]*\.[0-9]*\.[0-9]*$`

### Creating a release branch ###

    $ git checkout -b release-1.2.0 develop

### Finishing a release branch ###

    $ git checkout master

    $ git merge --no-ff release-1.2.0

    $ git tag -a 1.2.0

