#!/bin/sh
# pages.github.com
# Using .nojekyll does not help publish speed
# A smaller repo with symlinks does not help publish speed
cd $TRUNKNOTES/stuartjandrews.com/

# Commit and push source branch
git checkout source
#git add -A
#git commit -m "$(git status -s)"
#git push origin source

# Build site
mkdir -p .site
bin/jekyll --no-auto .site

# Push master branch
git checkout master

# Empty my repo, except ".git"
rm -r *
cp -r /_site/* .
git add -A
git commit -m "$(git status -s)"
git push origin master

# Back to source branch
git checkout source

# Check status
url="svnpenn.github.com/$(git status -s | head -1 | cut -c4-)"
original=$(wget -qO- $url)

while test "$original" = "$(wget -qO- $url)"; do
	for i in {1..10}; do
		# 10 seconds of filler, 10 dots
		echo -n '.'
		sleep 1
	done
done

echo 'Publish complete!'
