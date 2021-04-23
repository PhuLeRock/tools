proj_name=elearning
db_user=tamnguyenvt
db_pass=tamnguyenvt
db_name=elearning
site_name=Elearning
account_name=admin
account_pass=admin

function gotoProj(){
  cd $proj_name
}
mysqladmin -u tamnguyenvt -ptamnguyenvt create elearning

sudo apt-get install drush
sudo drush dl drupal --drupal-project-rename=$proj_name
gotoProj
sudo drush site-install standard --db-url="mysql://$db_user:$db_pass@localhost/$db_name" --site-name=$site_name --account-name=$account_name --account-pass=$account_pass

sudo chown -R www-data:www-data ./$proj_name