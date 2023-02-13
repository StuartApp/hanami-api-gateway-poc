# Hanami::API Gateway

## Usage
- RACK_ENV=production docker compose up --build

## API
- http://0.0.0.0:3000/

## API Health
- GET http://0.0.0.0:3000/health

## Benchmark
- ab -p inbound_body.json -T application/json -c 100 -n 2000 -k http://0.0.0.0:3000/
