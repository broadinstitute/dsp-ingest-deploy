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
Each profile in this repository models the full end-state of an ingest system. We eventually hope to break
common pieces into Terraform modules and Helm charts, but until then the only way to create a new profile
is to copy-paste an existing profile and tweak its parameters as needed.
