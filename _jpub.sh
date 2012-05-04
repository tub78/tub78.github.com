#!/bin/sh
# pages.github.com
# Using .nojekyll does not help publish speed
# A smaller repo with symlinks does not help publish speed

BLOG="$TRUNKNOTES/stuartjandrews.com"
BLOGPUB="$BLOG"-1


# Clone blog
git clone "$BLOG" "$BLOGPUB"
pushd "$BLOGPUB"
#git remote add origin git@github.com:tub78/tub78.github.com.git

# Checkout master branch
git checkout master
[ $? -eq 0 ] || { echo "Checkout Master Failed"; exit; };

# Wipe-clean repo, except dot files
rm -rf *

# Copy site folder 
cp -r "$BLOG"/_site/* .

# Display changes
git status -s

# Commit and push
git add -A
git commit -m "$(git status -s)"
git push origin master
[ $? -eq 0 ] || { echo "Push Failed"; exit; };

# Clean-up
popd
rm -rf "$BLOGPUB"
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
