# TODO

This file describes what you have to customize after you create a new rails application with railman

## .env

Check your settings in .env (database user/password, smpt server, emails, ...)

.env is gitignored. This is intended. You should create a local .env file on every server your deploy your rails application to, and modify the settings for that server. 

Try to keep all the application/server/environment specific settings, as well as all passwords here, as .env is not commited to git and exists only on a server or local user machine. This will also make future rails upgrades and changes in the configuration files less painful.

## create local database

Run `rake db:create`
