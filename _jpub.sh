#!/bin/sh
# pages.github.com
# Using .nojekyll does not help publish speed
# A smaller repo with symlinks does not help publish speed

pushd $TRUNKNOTES/stuartjandrews.com/


# Commit and push source branch
git checkout source
[ $? -eq 0 ] || exit;
git add -A
git commit -m "$(git status -s)"
git push origin source
[ $? -eq 0 ] || exit;

# Build site
mkdir -p .site
bin/jekyll --no-auto .site

exit;

# Push master branch
git checkout master

# Empty my repo, except ".git"
mkdir -p .hide
rsync -avu --include-from ".gitignore" --exclude "*" ./ .hide/
rm -rf *
rsync -avu --include-from ".gitignore" --exclude "*" .hide/ ./

# 
cp -r .site/* .
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
