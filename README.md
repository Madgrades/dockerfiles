# dockerfiles

Configurations for running the [Madgrades API](http://github.com/Madgrades/api.madgrades.com) along with all the required dependencies.

## Prerequisites

* Docker / Docker Compose
* [Create a GitHub OAuth app](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app) with the "Authorization callback URL" set to `http://localhost:3000/auth/github/callback`. 

## Instructions

1.
   Create a new `*.env` file (e.g. `prod.env`) based on the provided `.env.example`. The following steps and the GitHub callback URL above assume you leave the example defaults unchanged.

1.
   Create Docker volumes. This is helpful to persist data in between runs of the containers, and reuse volumes between containers.

   ```bash
   $ docker volume create madgrades-prod-mysql-data
   $ docker volume create madgrades-prod-elasticsearch-data
   $ docker volume create madgrades-prod-seed-data
   ```

2.
   Run all the services using configuration provided from the env file you created.

   ```bash
   $ docker compose --env-file=prod.env up
   ```

   This initializes the databases, seeds them with data, and starts up the API.

You can now access the API at the URL output by the command (e.g. `http://localhost:3000`). Optionally, use `up --detach` instead in order to detach and run the services in the background.

## Notes

### Starting the API alone

Specifying `up` without the specific services to initialize means that the command will re-seed the database everytime it is run. It is better to start and stop the API alone without re-seeding data.

```bash
$ docker compose --env-file=prod.env up api
```

### Re-seeding the databases

If new data is available, re-seed the database by updating the image in the Docker compose configuration and running the seed service.

```bash
$ docker compose --env-file=prod.env up seed
```

