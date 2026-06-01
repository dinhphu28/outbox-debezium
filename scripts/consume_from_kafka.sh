docker exec -it kafka /kafka/bin/kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic Order.events \
  --from-beginning

