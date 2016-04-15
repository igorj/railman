# TODO

This file describes what you have to customize after you create a new rails application with railman

## .env.example and .env

Copy .env.example, name the copy .env, and modify .env for your local development environment. 

.env is gitignored. This is intended. You should create a local .env file on every server your deploy your rails application to, and modify the settings for that server. 

Create secret token with `rake secret` and copy the secret to your .env file.

Try to keep all the application/server/environment specific settings, as well as all passwords here, as .env is not commited to git and exists only on a server or local user machine. This will also make future rails upgrades and changes in the configuration files less painful.
 