# First Steps

After you installed git you may want to execute the following commands:

    $ git config --global user.name "Alexander During"
    $ git config --global user.email alexander.during@something.com

Setting up some aliases:

    $ git config --global alias.st status
    $ git config --global alias.find grep -F
    $ git config --global alias.history "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --date-order"
