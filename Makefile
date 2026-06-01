# Makefile for Debezium Outbox Demo

.PHONY: up down restart logs create-connector consume test

# Start all services
up:
	docker compose up -d

# Stop all services
down:
	docker compose down

# Restart services
restart: down up

# View logs (follow)
logs:
	docker compose logs -f

# Create Debezium connector
create-connector:
	@echo "Creating Debezium connector..."
	chmod +x ./scripts/create_debezium_connector.sh
	./scripts/create_debezium_connector.sh

# Consume messages from Kafka
consume:
	@echo "Consuming messages from Kafka..."
	chmod +x ./scripts/consume_from_kafka.sh
	./scripts/consume_from_kafka.sh

# Full test flow
test: up
	@echo "Waiting for services to be ready..."
	sleep 10
	$(MAKE) create-connector
	@echo "Ready to consume events"
	$(MAKE) consume

