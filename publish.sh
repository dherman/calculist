#!/bin/bash

set -ev

cd ./_site

remote_repo="https://${GH_TOKEN}@github.com/dherman/calculist.git"
remote_branch='gh-pages'

git init
git config user.name "Travis CI"
git config user.email "nobody@nobody.org"

git add .
git commit -m 'travis build'
git push --force --quiet $remote_repo master:$remote_branch #> /dev/null 2>&1

rm -rf .git
cd ..
