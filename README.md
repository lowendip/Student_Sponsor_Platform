Install ruby on rails: https://guides.rubyonrails.org/install_ruby_on_rails.html (mise use -g ruby@3.4.3 will get you correct ruby version)
Pull project or unzip project: git clone https://github.com/lowendip/Student_Sponsor_Platform.git
Run: bundle install
Install postgres and login as psql (linux example can be seen below):
sudo apt install postgresql
sudo -u postgres psql

In postgres:
CREATE DATABASE db_name (default is platdb);
CREATE USER db_user (default is db_access) WITH ENCRYPTED PASSWORD 'password' (default is 'rails_db!)';
ALTER USER db_user (default is db_access) WITH SUPERUSER;
GRANT ALL PRIVILEGES ON DATABASE db_name (default is platdb) TO db_user (default is db_access);

Edit your environment in config/database.yml:
host: localhost (will likely be different for deployment server)
database: db_name (default is platdb)
username: db_user (default is db_access)
password: db_password (default is rails_db!)

Run: rails db:migrate
Start the application using: ./bin/rails s

