#!/bin/sh

LOCALREPO_VC_DIR=/var/www/giani.ondev/.git

if [ ! -d $LOCALREPO_VC_DIR ]
then
    echo "cloning..."
    git clone http://ondev:loadingplay007@gogs.ondev.today/loadingplay/sites.git /var/www/giani.ondev/
fi

echo "cd to /var/www/giani.ondev"
cd /var/www/giani.ondev
unset GIT_DIR

echo "checkout"
git checkout origin/master -f
git checkout master -f

echo "pull"
git pull

echo "npm and bower"
npm install
bower install

echo "change permissions"
chmod +x install_ondev.sh

