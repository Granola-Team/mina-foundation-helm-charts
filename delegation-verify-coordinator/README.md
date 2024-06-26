# Mina Delegation Coordinator

Coordinator component for Mina Delegation Program. This component is responsible for taking submissions data gathered by uptime-service-backend and running validation against them using stateless-verification-tool. Next, based on these validation results, the Coordinator builds its own database containing uptime score.

## TL;DR

```console
git clone https://github.com/MinaFoundation/helm-charts
cd helm-charts/delegation-verify-coordinator
helm install RELEASE_NAME ./ --namespace NAMESPACE
```

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0

## Installing the Chart

To install the chart with the release name `RELEASE_NAME`:

```console
helm install RELEASE_NAME ./ --namespace NAMESPACE
```

The command deploys `delegation-verify-coordinator` on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `RELEASE_NAME` deployment:

```console
helm delete RELEASE_NAME
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

### Charts configurable values

| Name                                 | Description                                               | Value           |
| ------------------------------------ | --------------------------------------------------------- | --------------- |
| `image.repository`                   | `delegation-verify-coordinator` docker image url          | `673156464838.dkr.ecr.us-west-2.amazonaws.com/delegation-verify-coordinator` |
| `image.tag`                          | Docker image tag                                          | `0.0.1` |
| `image.pullPolicy`                   | Docker image pull policy                                  | `IfNotPresent`  |
| `nameOverride`                       | Override Release Name                                     | `""` |
| `fullnameOverride`                   | Override Release and Chart Name                           | `""` |
| `coordinator.networkName`            | Network name in which coordinator should participate      | `""` |
| `coordinator.platform`               | Kubernetes cluster name where coordinator will run        | `""` |
| `coordinator.noChecks`               | Whether to use --no-checks for delegation verify. (0 is false, 1 is true)| `""` |
| `coordinator.surveyIntervalMinutes`  | Survey interval minutes                                   | `20` |
| `coordinator.command.override`       | Override default command. Use '"command"' notation. Can be a list  | `` |
| `coordinator.postgres.host`          | Postgres host. Default: templates like postgres helm chart| `{{ .Release.Name }}-postgresql` |
| `coordinator.postgres.port`          | Postgres port                                             | `` |
| `coordinator.postgres.db`            | Postgres database name                                    | `` |
| `coordinator.postgres.user`          | Postgres username                                         | `` |
| `coordinator.postgres.password`      | Postgres password                                         | `` |
| `coordinator.miniBatchNumber`        | Number of mini-batches to process within each main batch. | `2` |
| `coordinator.uptimeDaysForScore`     | Number of days the system must be operational to calculate a score. | `` |
| `coordinator.worker.image`           | Docker image name for the delegation verify               | `` |
| `coordinator.worker.tag`             | Docker image tag for the delegation verify                | `` |
| `coordinator.worker.cpu.request`     | CPU request for the delegation verify container           | `3` |
| `coordinator.worker.cpu.limit`       | CPU limit for the delegation verify container             | `4` |
| `coordinator.worker.memory.request`  | Memory request for the delegation verify                  | `3072Mi` |
| `coordinator.worker.memory.limit`    | Memory limit for the delegation verify                    | `4096Mi` |
| `coordinator.worker.ttlSecondsAfterFinished`| Time to live seconds after the job finished        | `43200` |
| `coordinator.aws.host`               | AWS host to connect to keyspace                           | `cassandra.us-west-2.amazonaws.com` |
| `coordinator.aws.port`               | AWS port to connect to keyspace                           | `9142` |
| `coordinator.aws.keyspace`           | AWS Keyspace name                                         | `` |
| `coordinator.aws.region`             | AWS Region                                                | `` |
| `coordinator.aws.accessKeyID`        | AWS Access Key ID                                         | `` |
| `coordinator.aws.secretAccessKey`    | AWS Secret Access Key                                     | `` |
| `coordinator.aws.s3Bucket`           | AWS S3 Bucket name that holds submissions                 | `673156464838-uptime-service-backend` |
| `coordinator.ssl.certfile`           | Path to the certfile for AWS Keyspaces                    | `` |
| `coordinator.envVars`                | Environment Variables to pass to the container            | `[]` |
| `serviceAccount.create`              | Create or not Service Account                             | `true` |
| `serviceAccount.automount`           | Automatically mount ServiceAccount API credentials        | `true` |
| `serviceAccount.coordinator.annotations`| Annotations for the Coordinator Service Account        | `{}` |
| `serviceAccount.worker.annotations`  | Annotations for the Worker Service Account                | `{}` |
| `serviceAccount.name`                | If specified, name of the service account                 | ` `  |
| `secret.gcpServiceAccount`           | JSON data of gcp sa credentials                           | ` `  |
| `podAnnotations`                     | Pod annotations                                           | `{}` |
| `podLabels`                          | Pod labels                                                | `{}` |
| `affinity`                           | Pod affinity                                              | `{}` |
| `service.type`                       | Service type                                              | `ClusterIP` |
| `service.port`                       | Service port                                              | `80` |
| `replicas`                           | Amount of replicas to deploy                              | `1` |
| `resources.request.memory`           | Memory requested for the application pod                  | `256Mi` |
| `resources.request.cpu`              | CPU resources requested for the application pod           | `500m` |
| `resources.limit.memory`             | Maximum memory allowed for the application pod            | `512Mi` |
| `resources.limit.cpu`                | Maximum CPU resources allowed for the application pod     | `1` |
