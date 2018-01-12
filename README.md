# gpodder
docker-compose files to build a local gpodder.net server.
```

## Status

- Machines come up and can subscribe to topics.  
- Devices can sync.  
- Search doesn't work.  
- Must set DEBUG=True (until find how to move staticfiles)

## Usage
```bash
$ docker-compose up -d
$ docker exec mygpo_app_1 python manage.py migrate # sets up DB
```
