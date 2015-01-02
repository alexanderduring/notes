Migration from Subversion to Git
================================

What we have
------------

Starting point is

- A subversion repository on a server
- Several developers using subversion clients
- One developer using git-svn for over year now
- A ci server (jenkins) building trunk on every commit
- Several deployment scripts for stage and production servers


Strategy
--------

- create a bare git repository from the local git repository of the developer, which used git-svn for over a year.
- Move this bare git repository to the repository server.
- Add branches following the [Git Branching Model by Vincent Driessen](http://nvie.com/posts/a-successful-git-branching-model/)
- Adapt jenkins to build the *develop* branch
- Create access for every developer to git repository
- Adapt deployment scripts


Create a bare Git repository from a local Git repository
--------------------------------------------------------

To create a bare git repository from a local one that contains only the master branch you need at least git version 1.7.10:

    $ git clone -b master --single-branch --bare path/to/local-repo repo.git


Move the Git repository to the server
-------------------------------------

Create an archive out of it and copy it to the server

    $ tar -czf repo.git.tgz repo.git
    $ scp repo.git.tgz user@server:~

And extract and install it there.


Add branches following the Git Branching Model
----------------------------------------------

First clone the repository

    $ git clone git@server:repo.git

After that, create a local branch *develop*

    $ git branch develop

And push it to the origin

    $ git push -u origin develop

This tells git to push changes from your develop branch to the develop branch on the origin repository. If origin does not have a develop branch, it is created on the fly. The -u tells git that you want to be able to easily push and pull changes to that branch in the future.


Adapt jenkins to build the *develop* branch
-------------------------------------------

Update your Jenkins installation and install the [Git Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin).

Repository URL should be in the format:

    git@hostname.com:repository

Now you can set up the jenkins job as usual.


Empty directories in your project
---------------------------------

Subversion allows you to have empty directories in your project, git does not. To find all empty directories in the project do a subversion export:

    $ svn export <project-url>

In the resulting project, look for empty directories by using:

    $ find . -empty -type d

Decide for each empty directory, if you want to remove it or place a .gitignore, a .gitkeep or a readme file in it.


