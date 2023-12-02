#!/bin/bash
FETCH_SEED_DATA_CONTAINER=fetch-seed-data

FETCH_SEED_DATA_IMAGE_CURRENT=$(docker compose images $FETCH_SEED_DATA_CONTAINER -q)
FETCH_SEED_DATA_DIGEST_CURRENT=$(docker inspect --format='{{index .RepoDigests 0}}' $FETCH_SEED_DATA_IMAGE_CURRENT)
echo "Current fetch-seed-data digest: $FETCH_SEED_DATA_DIGEST_CURRENT"

echo "Pulling latest versions..."
docker compose pull

echo "Starting latest fetch-seed-data..."
docker compose up fetch-seed-data

FETCH_SEED_DATA_IMAGE_UPDATED=$(docker compose images $FETCH_SEED_DATA_CONTAINER -q)
FETCH_SEED_DATA_DIGEST_UPDATED=$(docker inspect --format='{{index .RepoDigests 0}}' $FETCH_SEED_DATA_IMAGE_UPDATED)
echo "Updated fetch-seed-data digest: $FETCH_SEED_DATA_DIGEST_UPDATED"

echo "Running migrations..."
docker compose up migrate

# if [ "$FETCH_SEED_DATA_DIGEST_CURRENT" == "$FETCH_SEED_DATA_DIGEST_UPDATED" ]; then
  # echo "Skipping seed, no new seed data available"
# else
  # echo "Running seed with new seed data..."
  docker compose up seed
# fi

echo "Stopping containers..."
docker compose stop

echo "Starting api..."
docker compose up -d api
echo "Done"
