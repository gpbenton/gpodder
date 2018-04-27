# gpodder
docker-compose files to build a local gpodder.net server.

## Status

- Machines come up and can subscribe to topics.  
- Devices can sync.  
- Search doesn't work the first attempt.  Subsequent attempts work fine.

## Usage

- Download this module and cd into it.
- Create a .env file with

```bash
SECRET_KEY=your_made_up_django_secret
DEFAULT_BASE_URL=http://localhost:8000/
DEBUG=False
```

Then the following commands

```bash
$ mkdir static    # create a directory to reveal static images for web server
$ docker-compose up -d
$ docker exec gpodder_app_1 python manage.py migrate # sets up DB
$ docker exec gpodder_app_1 python manage.py collectstatic  # Moves static files to /staticfiles/ which should be shown in ./static dir
```

Then connect to localhost:8000 with your browser.  I go through caddy with this configuration.

```
http://localhost:2015 {
  root /var/www/gpodder/
  redir {
    /clientconfig.json /static/clientconfig.json
    /failpodder.svg /static/failpodder.svg
    /favicon.ico /static/favicon.ico
    /favicon.png /static/favicon.png
    /robots.txt /static/robots.txt
  }
  proxy / gpodder_app_1:8000 {
    transparent
    except /static/ /clientconfig.json /failpodder.svg /favicon.ico /favicon.png /robots.txt
  }
  log  stdout 
}
```

I haven't found a way to use subdirectories.

### Upgrading

```bash
docker-compose pull
docker-compose build --pull
docker-compose up -d
docker exec gpodder_app_1 python manage.py collectstatic  # Moves static files to /staticfiles/ which should be shown in ./static dir
```
