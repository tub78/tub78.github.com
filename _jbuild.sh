#!/bin/sh
# pages.github.com
# Using .nojekyll does not help publish speed
# A smaller repo with symlinks does not help publish speed

pushd "$TRUNKNOTES/stuartjandrews.com/"


# Checkout source branch
git checkout source
[ $? -eq 0 ] || { echo "Checkout Source Failed"; exit; };

# Commit and push
git add -A
git commit -m "$(git status -s)"
git push origin source
[ $? -eq 0 ] || { echo "Push Failed"; exit; };

# Build site
bin/jekyll --no-auto
[ $? -eq 0 ] || { echo "Jekyll Build Failed"; exit; };

echo 'Jekyll Build Complete!'
