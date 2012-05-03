#!/bin/sh
# pages.github.com
# Using .nojekyll does not help publish speed
# A smaller repo with symlinks does not help publish speed

pushd "$TRUNKNOTES/stuartjandrews.com/"


# Checkout master branch
git checkout master
[ $? -eq 0 ] || exit;

# Wipe-clean repo, except dot files and ".gitignore" files
mkdir -p .hide
rsync -avu --include-from ".gitignore" --exclude "*" ./ .hide/
rm -rf *
rsync -avu --include-from ".gitignore" --exclude "*" .hide/ ./

# Copy site folder 
cp -r .site/* .

# Display changes
git status -s

# Commit and push
git add -A
git commit -m "$(git status -s)"
git push origin master

# Back to source branch
git checkout source
[ $? -eq 0 ] || exit;

echo 'Jekyll Publish complete!'
exit;


# Check status
url="tub78.github.com/$(git status -s | head -1 | cut -c4-)"
original=$(wget -qO- $url)

while test "$original" = "$(wget -qO- $url)"; do
	for i in {1..10}; do
		# 10 seconds of filler, 10 dots
		echo -n '.'
		sleep 1
	done
done

echo 'Publish complete!'
