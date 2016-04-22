# Docker Compose Setup for Helpy.io

This repository contains the neccessary files to run your own helpy.io instance. Thanks to Caddy and let's encrypt, everything is https encrypted (if you have a domain)

### How to run?
- modify `.env` and `Caddyfile`
- point your domain to the ip of your server
- wait for dns change propagation
- run `docker-compose up -d`

### What does not work? (aka Todo)
- cloudinary (COPY in Dockerfile)
- Email is untested
