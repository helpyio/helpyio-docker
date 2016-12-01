# MAINTAINER NEEDED!

We are looking for a new maintainer for docker container.  Please join us in Slack if you can help! https://helpyioslackin.herokuapp.com/

# Docker Compose Setup for Helpy.io

This repository contains the neccessary files to run your own helpy.io instance. Thanks to Caddy and let's encrypt, everything is https encrypted (if you have a domain)

### How to run?
- modify `.env` and `Caddyfile`
- optionally, create a modified [`seeds.rb`](https://github.com/helpyio/helpy/blob/master/db/seeds.rb) and mount it into the helpy container
- point your domain to the ip of your server
- wait for dns change propagation
- run `docker-compose up -d`

### What do you need to know
- If you set `DO_NOT_PREPARE=true` in the `.env` file, asset precompilation and database migrations will be skipped. It is advised to leave this alone to ensure running database migrations on version change

### What does not work? (aka Todo)
- Email is untested
- Caddy static gzip
- Mailin Container
