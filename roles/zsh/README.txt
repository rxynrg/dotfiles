1. How to recursively rename files (change extension)?

$ autoload zmv
$ zmv -n '(**/)(*).yaml' '$1$2.yml'
$ # Remove the -n to actually perform the renaming.

2.