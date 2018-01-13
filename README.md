# gpodder
docker-compose files to build a local gpodder.net server.

## Status

- Machines come up and can subscribe to topics.  
- Devices can sync.  
- Search doesn't work.  

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
$ docker-compose up -d
$ docker exec gpodder_app_1 python manage.py migrate # sets up DB
$ docker exec gpodder_app_1 python manage.py collectstatic  # Moves static files to /staticfiles/
```

Then connect to localhost:8000 with your browser.  I go through caddy with this configuration.  The `gpodder_data_dir` volume is mounted at `/var/www/gpodder`

```
http://localhost:2015 {
  root /var/www/gpodder/htdocs
  proxy / gpodder_app_1:8000 {
    transparent
    except /media/
  }
  log  stdout 
}
```

I haven't found a way to use subdirectories.

