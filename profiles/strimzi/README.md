# Strimzi
This deployment profile declares all the custom resource definitions needed
for managing Kafka in k8s, and deploys the strimzi cluster operator to process
the custom requests.

It should be deployed once per namespace before attempting to use Kafka.
