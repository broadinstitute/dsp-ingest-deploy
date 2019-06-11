# Project Base
This deployment profile contains the Terraform needed to set up ingest "singletons"
in a new GCP project, including:
1. Network rules
2. CloudSQL instance
3. k8s cluster

It should be deployed once per environment / ingest project as the first step of
setting up new GCP resources.
