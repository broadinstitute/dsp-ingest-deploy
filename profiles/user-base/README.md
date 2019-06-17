# User Base
This deployment profile initializes ingest resources which might be used in multiple
services, but should be restricted to a single "owner". These include:
1. A CloudSQL database (within an existing instance) & user
2. A k8s namespace named after the owner
3. The strimzi cluster operator, running within the namespace

This profile should be deployed once per owner after initializing the base of the
enclosing project.

## Project Initialization
The easiest way to initialize a project is to deploy the [`project-base`](../project-base/README.md)
profile into it. In cases when that profile can't or shouldn't be deployed, the
information needed by this profile can still be manually written to Vault:
```bash
$ vault write secret/dsde/monster/${ENVIRONMENT}/ingest/${INGEST_PROJECT}/cloudsql/instance name=${DB_NAME}
```

## Upgrading Strimzi
The [`install-strimzi`](../../scripts/install-strimzi) script can be used to install
new k8s configs for the strimzi cluster-operator into this profile. _NOTE_ that the script just overwrites
the existing configs and does some namespace rewriting. If there are any special actions that need to be
taken to upgrade a running strimzi operator, they must be performed manually for now.
