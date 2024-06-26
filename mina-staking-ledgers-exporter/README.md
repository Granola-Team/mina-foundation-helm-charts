# Mina Staking Ledger Exporter

mina-staking-ledgers-exporter is a tools that generate Mina Staking Ledgers, and publish them on S3 and Mina Payout Data Provider API.

## TL;DR

```console
git clone https://github.com/MinaFoundation/helm-charts
cd helm-charts/mina-staking-ledgers-exporter
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

The command deploys mina-staking-ledgers-exporter on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `RELEASE_NAME` deployment:

```console
helm delete RELEASE_NAME
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

| Name                                                              | Description                                                                        | Value                                                                |
| ----------------------------------------------------------------- | ---------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| `image.repository`                                                | mina-staking-ledgers-exporter image name                                       | `673156464838.dkr.ecr.us-west-2.amazonaws.com/github-actions-runner` |
| `image.pullPolicy`                                                | mina-staking-ledgers-exporter image pull policy                                | `IfNotPresent`                                                       |
| `image.pullSecrets`                                               | Specify docker-registry secret names as an array                                   | `[]`                                                                 |
| `nameOverride`                                                    | String to partially override common.names.fullname                                 | ""                                                                   |
| `fullnameOverride`                                                | String to fully override common.names.fullname                                     | ""                                                                   |
| `serviceAccount.create`                                           | Enable the creation of a ServiceAccount for mina-staking-ledgers-exporter pods | `true`                                                               |
| `serviceAccount.annotations`                                      | Annotations for the created ServiceAccount                                         | {}                                                                   |
| `serviceAccount.name`                                             | Name of the created ServiceAccount                                                 | ""                                                                   |
| `podAnnotations`                                                  | Annotations for mina-staking-ledgers-exporter pods                             | {}                                                                   |
| `podLabels`                                                       | Extra labels for mina-staking-ledgers-exporter pods                            | {}                                                                   |
| `podRegexPattern`                                                 | Regex pattern to match pods                                                        | ".*"                                                                 |
| `schedule`                                                        | Schedule to run pod rotation, runs every 6 hours                                   | "0 */6 * * *"                                                        |
| `restartPolicy`                                                   | Restart Policy when the job fails, can be OnFailure, Never, Always                 | "OnFailure"                                                          |
| `podSecurityContext`                                              | Set mina-staking-ledgers-exporter Pod's Security Context                       | {}                                                                   |
| `securityContext`                                                 | Set mina-staking-ledgers-exporter Security Context                             | {}                                                                   |
| `resources.limits`                                                | The resources limits for the mina-staking-ledgers-exporter container           | {}                                                                   |
| `resources.requests`                                              | The resources requests for the mina-staking-ledgers-exporter container         | {}                                                                   |
| `nodeSelector`                                                    | Node labels for pod assignment                                                     | {}                                                                   |
| `tolerations`                                                     | Tolerations for pod assignment                                                     | {}                                                                   |
| `affinity`                                                        | Affinity for pod assignment                                                        | {}                                                                   |
| `schedule`                                                        | Frequency to run the job                                                           | `0 0 * * *`                                                          |
| `restartPolicy`                                                   | Restart Policy                                                                     | `Never`                                                              |
| `minaStakingLedgersExporter.network`                          | Network to run the Exporter against                                            | ` `                                                                  |
| `minaStakingLedgersExporter.s3.bucket`                        | Bucket to upload the Mina Staking Ledgers                                          | ` `                                                                  |
| `minaStakingLedgersExporter.s3.subpath`                       | Bucket subpath to upload the Mina Staking Ledgers                                  | ` `                                                                  |
| `minaStakingLedgersExporter.minaNodeLabel`                    | Label of the Mina Daemon to execute Staking Ledger Generation                      | ` `                                                                  |
| `minaStakingLedgersExporter.slackWebhookInfoUrl`              | Slack Webhook Info URL                                                             | ` `                                                                  |
| `minaStakingLedgersExporter.slackWebhookWarnUrl`              | Slack Webhook Warn URL                                                             | ` `                                                                  |
| `minaStakingLedgersExporter.minaPayoutsDataProvider.url`      | Mina Payouts Data Provider URL                                                     | ` `                                                                  |
| `minaStakingLedgersExporter.minaPayoutsDataProvider.username` | Mina Payouts Data Provider Username                                                | ` `                                                                  |
| `minaStakingLedgersExporter.minaPayoutsDataProvider.password` | Mina Payouts Data Provider Password                                                | ` `                                                                  |
