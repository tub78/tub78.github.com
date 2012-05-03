#!/bin/sh
# pages.github.com
# Using .nojekyll does not help publish speed
# A smaller repo with symlinks does not help publish speed

pushd "$TRUNKNOTES/stuartjandrews.com/"


# Checkout source branch
git checkout source
[ $? -eq 0 ] || exit;

# Commit and push
git add -A
git commit -m "$(git status -s)"
git push origin source
[ $? -eq 0 ] || exit;

# Build site
mkdir -p .site
bin/jekyll --no-auto .site
[ $? -eq 0 ] || exit;

echo 'Build complete!'
