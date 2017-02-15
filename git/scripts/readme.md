# Git Scripts

## Contents

  * list-missing-tags
  
## List Missing Tags

This scripts shows you a list of all tags that are present on origin/master, but not on the local working copy of your current branch (HEAD).

```
$ list-missing-tags

Tags on master but not on <your-branch-name>:
  v1.20.0
  v1.19.3

$
```

Tags must match the following patters: ```v?[0-9]*\.[0-9]*\.[0-9]*```
