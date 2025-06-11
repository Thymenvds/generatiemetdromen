# Docs for database (mijn visie)

uses pysondb-v2 (install pip install pysondb-v2)

Each table is stored in a single .json file

```shell
cd mijnvisie
fastapi dev server.py
```

## Tables

1. User (info about users)
2. Questions ("Mijn visie" question + multiple choice answers)
3. Answers (answer of users on questions)

## Queries

We use fastAPI to route our request to db queries

## TODO

[ ] auth
[ ] access control (through auth)
[ ] validation


## Notes toegevoed thymen

docker compose up --build

de website en de server staat nu online respectievelijk op localhost:8080 and localhost:8000
