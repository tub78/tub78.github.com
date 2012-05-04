#!/bin/sh

BLOG="$TRUNKNOTES/stuartjandrews.com"
BLOGPUB="$BLOG"-0

# Clone blog locally 
git clone "$BLOG" "$BLOGPUB"
pushd "$BLOGPUB"

# Checkout master branch
git checkout master
[ $? -eq 0 ] || { echo "Checkout Master Failed"; exit; };

# Wipe-clean repo, except dot files
rm -rf *

# Copy site folder & commit
cp -r "$BLOG"/_site/* .
git add -A
git commit -m "$(git status -s)"

# Push locally
git push origin master
[ $? -eq 0 ] || { echo "Push Failed"; exit; };

# Create additional GH remote & push there too
git remote add origin0 git@github.com:tub78/tub78.github.com.git
git push origin0 master
[ $? -eq 0 ] || { echo "Push Failed"; exit; };

# Clean-up
popd
rm -rf "$BLOGPUB"
echo 'Jekyll Publish complete!'


