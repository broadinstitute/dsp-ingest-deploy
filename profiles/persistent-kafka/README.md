# Persistent Kafka
This deployment profile initializes a deployment of Zookeeper and Kafka backed by
persistent storage. The volumes backing the storage are resizable and will not be
deleted if the deployment is torn down, so it is suitable for long-lived deployments.

It should be deployed once per namespace before attempting to deploy other ingest services.
