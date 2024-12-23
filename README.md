# Pet Tracking Application - Docker Setup

## Prerequisites

- Docker
- Docker Compose

## Getting Started

1. Clone the repository
2. Build the Docker image:

```bash
docker-compose build
```

3. Create the database and run migration:

```bash
docker-compose run web rails db:create
docker-compose run web rails db:migrate
```

4. Start the application:

```bash
docker-compose up
```

The application will be available at http://localhost:3000

## Running Tests

To run the tests:

```bash
docker-compose run web rspec
```

## Making API Requests

# API Usage Examples

## Create a new pet (Dog)

```bash
curl -X POST http://localhost:3000/api/v1/pets \
  -H "Content-Type: application/json" \
  -d '{
    "pet": {
      "pet_type": "Dog",
      "tracker_type": "small",
      "owner_id": 1,
      "in_zone": false
    }
  }'
```

## Create a new pet (Cat)

```bash
curl -X POST http://localhost:3000/api/v1/pets \
  -H "Content-Type: application/json" \
  -d '{
    "pet": {
      "pet_type": "Cat",
      "tracker_type": "small",
      "owner_id": 2,
      "in_zone": true,
      "lost_tracker": false
    }
  }'
```

## Get pets outside power saving zone

```bash
curl http://localhost:3000/api/v1/pets
```
