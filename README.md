# gpodder
docker-compose files to build a local gpodder.net server.
```

## Status

- Machines come up and can subscribe to topics.  
- Devices can sync.  
- Search doesn't work.  

## Usage

- Download this module and cd into it.
- Create a .env file with
```
SECRET_KEY=your_made_up_django_secret
DEFAULT_BASE_URL=http://localhost:8000/
DEBUG=False
```

Then the following commands

```bash
$ docker-compose up -d
$ docker exec mygpo_app_1 python manage.py migrate # sets up DB
$ docker exec mygpo_app_1 ls staticfiles # Moves static files to /staticfiles/
```

Then connect to localhost:8000 with your browser.  I go through caddy with this configuration

```
http://localhost:2015 {
  proxy / mygpo_app_1:8000 {
    transparent
  }
  log  stdout 
}
```

I haven't found a way to use subdirectories.

