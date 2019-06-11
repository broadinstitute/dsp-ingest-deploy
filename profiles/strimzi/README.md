# Strimzi
This deployment profile declares all the custom resource definitions needed
for managing Kafka in k8s, and deploys the strimzi cluster operator to process
the custom requests.

It should be deployed once per namespace before attempting to use Kafka.

## Upgrading
The [`install-strimzi`](../../scripts/install-strimzi) script can be used to install
new k8s configs for the cluster-operator into the profile directory. _NOTE_ that the
script just overwrites the existing configs and does some namespace rewriting. If there
are any special actions that need to be taken to upgrade a running strimzi operator,
they must be performed manually for now.
