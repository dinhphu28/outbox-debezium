curl -X POST http://localhost:8083/connectors \
  -H "Content-Type: application/json" \
  -d '{
    "name": "outbox-connector",
    "config": {
      "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
      "database.hostname": "postgres",
      "database.port": "5432",
      "database.user": "postgres",
      "database.password": "postgres",
      "database.dbname": "mydb",

      "topic.prefix": "myapp",

      "plugin.name": "pgoutput",

      "table.include.list": "public.outbox_event",

      "tombstones.on.delete": "false",

      "transforms": "outbox",
      "transforms.outbox.type": "io.debezium.transforms.outbox.EventRouter",

      "transforms.outbox.route.by.field": "aggregate_type",
      "transforms.outbox.route.topic.replacement": "${routedByValue}.events",

      "transforms.outbox.table.field.event.id": "id",
      "transforms.outbox.table.field.event.key": "aggregate_id",
      "transforms.outbox.table.field.event.type": "type",
      "transforms.outbox.table.field.event.payload": "payload",
      "transforms.outbox.table.field.event.aggregate.type": "aggregate_type",

      "transforms.outbox.table.fields.additional.placement": "type:header:eventType"
    }
}' -v
