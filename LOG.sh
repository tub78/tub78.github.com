# 2012-04-18 (installing gems: jekyll, redcarpet 2)
bundle install --path vendor/bundle
bundle install --binstubs
exit;

# 2012-03-09
git add -f Gemfile Gemfile.lock
exit;

# 2012-03-09
echo ".bundle\nvendor\n" >> .gitignore
exit;


# 2012-03-09 (installing jekyll)
bundle install --path vendor/bundle
bundle install --binstubs
exit;



# 2012-03-10 tub78.github.com
cd $TRUNKNOTES/
mkdir tub78.github.com
cd tub78.github.com
git init
echo "Hello World!" > index.html
echo "Sorry, there is nothing here." > 404.html
git add index.html 404.html
git commit -m 'Setup'
git remote add origin git@github.com:tub78/tub78.github.com.git
git push -u origin master
exit;


