#!/bin/bash

echo -e "\033[0;32mDeploying updates to Github...\033[0m"

# Build the project.
hugo -t minimal-light

cd public

# Add changes to git.
git add .

msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
cd ..
#git subtree push --prefix=public git@github.com:ajnarayan/ajnarayan.github.io.git gh-pages