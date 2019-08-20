# DSP Ingest Deploy
Deployment profiles for DSP's ingest infrastructure, including (so far):
1. Terraform for k8s and CloudSQL
2. [strimzi](https://github.com/strimzi/strimzi-kafka-operator) for managing Kafka as k8s custom resources
3. [Transporter](https://github.com/DataBiosphere/transporter) for bulk file transfers

## Running Commands
We lean on DSP's [common k8s deploy infrastructure](https://github.com/broadinstitute/dsp-k8s-deploy). To do
most of the work when running deploy commands. The common code is pulled in as a submodule, so first make
sure it's been cloned:
```bash
$ git submodule update --init
```

Once all code is pulled, run the main script:
```bash
$ ./scripts/run-command -h
```

## Setting Up a New Project
With one exception (DNS zone), each profile in this repository models the full end-state of an ingest system.

We eventually hope to break common pieces into Terraform modules and Helm charts, but until then the only way
to create a new profile is to copy-paste an existing profile and tweak its parameters as needed.

### Why Separate DNS?
Setting up DNS on a new subdomain requires:
1. BITS to delegate the subdomain to our infrastructure
2. DevOps to generate new wildcard SSL certs for the subdomain

Historically, both of these processes have been slow to complete, error-prone, and difficult for us to track.
Once we got working setups for 'monster-dev' and 'monster-prod', we chose to use those as the subdomains of
every ingest project (vs. having per-project subdomains like 'monster-v2f-prod'). Since these zones are effectively
globals and should only be run against our "core" projects, we separated out their Terraform into a stand-alone
setup which can be run once per env.
