# dockerfiles

Configurations for running the [Madgrades API](http://github.com/Madgrades/api.madgrades.com) along with all the required dependencies.

## Prerequisites

* Docker / Docker Compose
* [Create a GitHub OAuth app](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app) with the "Authorization callback URL" set to `http://localhost:8080/auth/github/callback`. 

## Instructions

1.
   Create a new `.env` file based on the provided `.env.example`. The following steps and the GitHub callback URL above assume you leave the example defaults unchanged.

1.
   Run all the services using configuration provided from the env file you created.

   ```bash
   $ docker compose up --detach
   ```

   This initializes the databases, seeds them with data, and starts up the API.

You can now access the API (`http://localhost:8080` if you left the default settings). Opionally, do not use `--detach` in order to attach to the server.

You can also access the frontend (`http://localhost:3000` if you left the default settings). Note that for the first run you will need to access the API, login with your GitHub account and get a Madgrades API token, and restart the frontend with that token set in the environment variables:

```bash
$ docker compose down frontend
$ docker compose up frontend --detach
```

## Notes

### Re-seeding the databases

If new data is available, re-seed the database by updating the image in the Docker compose configuration and running the seed service. This service will terminate after the seeding is completed.

```bash
$ docker compose up seed
```

### Start the frontend and API without re-seeding

Skip re-seeding the database by specifying the `frontend` and `api` services to start.

```bash
$ docker compose up frontend api --detach
```

### Running multiple instances

To run multiple instances, configure a new environment variables file, e.g. `.env.dev`, and specify it with your Docker compose commands:

```bash
docker compose --env-file=.env.dev up frontend api --detach
```