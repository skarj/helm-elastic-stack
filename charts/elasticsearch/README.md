# Elasticsearch Helm Chart

This chart uses a standard Docker image of Elasticsearch (docker.elastic.co/elasticsearch/elasticsearch-oss) and uses a service pointing to the master's transport port for service discovery.
Elasticsearch does not communicate with the Kubernetes API, hence no need for RBAC permissions.

## Prerequisites Details

* Kubernetes 1.6+
* PV dynamic provisioning support on the underlying infrastructure

## StatefulSets Details
* https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/

## StatefulSets Caveats
* https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#limitations

## Todo

* Implement TLS/Auth/Security
* Smarter upscaling/downscaling
* Solution for memory locking

## Chart Details
This chart will do the following:

* Implemented a dynamically scalable elasticsearch cluster using Kubernetes StatefulSets/Deployments
* Multi-role deployment: master, client (coordinating) and data nodes
* Statefulset Supports scaling down without degrading the cluster

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
$ helm install --name my-release incubator/elasticsearch
```

## Deleting the Charts

Delete the Helm deployment as normal

```
$ helm delete my-release
```

Deletion of the StatefulSet doesn't cascade to deleting associated PVCs. To delete them:

```
$ kubectl delete pvc -l release=my-release,component=data
```

## Configuration

The following table lists the configurable parameters of the elasticsearch chart and their default values.

|              Parameter               |                             Description                             |               Default                |
| ------------------------------------ | ------------------------------------------------------------------- | ------------------------------------ |
| `appVersion`                         | Application Version (Elasticsearch)                                 | `6.3.2`                              |
| `image.repository`                   | Container image name                                                | `docker.elastic.co/elasticsearch/elasticsearch-oss` |
| `image.tag`                          | Container image tag                                                 | `6.3.2`                              |
| `image.pullPolicy`                   | Container pull policy                                               | `Always`                             |
| `cluster.name`                       | Cluster name                                                        | `elasticsearch`                      |
| `cluster.kubernetesDomain`           | Kubernetes cluster domain name                                      | `cluster.local`                      |
| `cluster.xpackEnable`                | Writes the X-Pack configuration options to the configuration file   | `false`                              |
| `cluster.config`                     | Additional cluster config appended                                  | `{}`                                 |
| `cluster.env`                        | Cluster environment variables                                       | `{}`                                 |
| `client.enabled`                     | Create coordinating nodes                                           | `false`                              |
| `client.name`                        | Client component name                                               | `client`                             |
| `client.replicas`                    | Client node replicas (deployment)                                   | `2`                                  |
| `client.resources`                   | Client node resources requests & limits                             | `{} - cpu limit must be an integer`  |
| `client.priorityClassName`           | Client priorityClass                                                | `nil`                                |
| `client.heapSize`                    | Client node heap size                                               | `512m`                               |
| `client.podAnnotations`              | Client Deployment annotations                                       | `{}`                                 |
| `client.nodeSelector`                | Node labels for client pod assignment                               | `{}`                                 |
| `client.tolerations`                 | Client tolerations                                                  | `{}`                                 |
| `client.serviceAnnotations`          | Client Service annotations                                          | `{}`                                 |
| `client.serviceType`                 | Client service type                                                 | `ClusterIP`                          |
| `master.enabled`                     | Create master nodes                                                 | `false`                              |
| `master.exposeHttp`                  | Expose http port 9200 on master Pods for monitoring, etc            | `false`                              |
| `master.name`                        | Master component name                                               | `master`                             |
| `master.replicas`                    | Master node replicas (deployment)                                   | `2`                                  |
| `master.resources`                   | Master node resources requests & limits                             | `{} - cpu limit must be an integer`  |
| `master.priorityClassName`           | Master priorityClass                                                | `nil`                                |
| `master.podAnnotations`              | Master Deployment annotations                                       | `{}`                                 |
| `master.nodeSelector`                | Node labels for master pod assignment                               | `{}`                                 |
| `master.tolerations`                 | Master tolerations                                                  | `{}`                                 |
| `master.heapSize`                    | Master node heap size                                               | `512m`                               |
| `master.name`                        | Master component name                                               | `master`                             |
| `master.persistence.enabled`         | Master persistent enabled/disabled                                  | `true`                               |
| `master.persistence.name`            | Master statefulset PVC template name                                | `data`                               |
| `master.persistence.size`            | Master persistent volume size                                       | `4Gi`                                |
| `master.persistence.storageClass`    | Master persistent volume Class                                      | `nil`                                |
| `master.persistence.accessMode`      | Master persistent Access Mode                                       | `ReadWriteOnce`                      |
| `data.enabled`                       | Create data nodes                                                   | `false`                              |
| `data.exposeHttp`                    | Expose http port 9200 on data Pods for monitoring, etc              | `false`                              |
| `data.replicas`                      | Data node replicas (statefulset)                                    | `3`                                  |
| `data.resources`                     | Data node resources requests & limits                               | `{} - cpu limit must be an integer`  |
| `data.priorityClassName`             | Data priorityClass                                                  | `nil`                                |
| `data.heapSize`                      | Data node heap size                                                 | `1536m`                              |
| `data.persistence.enabled`           | Data persistent enabled/disabled                                    | `true`                               |
| `data.persistence.name`              | Data statefulset PVC template name                                  | `data`                               |
| `data.persistence.size`              | Data persistent volume size                                         | `30Gi`                               |
| `data.persistence.storageClass`      | Data persistent volume Class                                        | `nil`                                |
| `data.persistence.accessMode`        | Data persistent Access Mode                                         | `ReadWriteOnce`                      |
| `data.podAnnotations`                | Data StatefulSet annotations                                        | `{}`                                 |
| `data.nodeSelector`                  | Node labels for data pod assignment                                 | `{}`                                 |
| `data.tolerations`                   | Data tolerations                                                    | `{}`                                 |
| `data.terminationGracePeriodSeconds` | Data termination grace period (seconds)                             | `3600`                               |
| `data.antiAffinity`                  | Data anti-affinity policy                                           | `soft`                               |
| `master_data.enabled`                | Create master_data nodes                                            | `true`                               |
| `master_data.name`                   | master_data component name                                          | `master-data`                        |
| `master_data.exposeHttp`             | Expose http port 9200 on data Pods for monitoring, etc              | `false`                              |
| `master_data.replicas`               | Data node replicas (statefulset)                                    | `1`                                  |
| `master_data.resources`              | Data node resources requests & limits                               | `{} - cpu limit must be an integer`  |
| `master_data.priorityClassName`      | Data priorityClass                                                  | `nil`                                |
| `master_data.heapSize`               | Data node heap size                                                 | `1536m`                              |
| `master_data.persistence.enabled`    | Data persistent enabled/disabled                                    | `true`                               |
| `master_data.persistence.name`       | Data statefulset PVC template name                                  | `data`                               |
| `master_data.persistence.size`       | Data persistent volume size                                         | `30Gi`                               |
| `master_data.persistence.storageClass`| Data persistent volume Class                                        | `nil`                                |
| `master_data.persistence.accessMode` | Data persistent Access Mode                                         | `ReadWriteOnce`                      |
| `master_data.podAnnotations`         | Data StatefulSet annotations                                        | `{}`                                 |
| `master_data.nodeSelector`           | Node labels for data pod assignment                                 | `{}`                                 |
| `master_data.tolerations`            | Data tolerations                                                    | `{}`                                 |
| `master_data.terminationGracePeriodSeconds` | Data termination grace period (seconds)                             | `3600`                               |
| `master_data.antiAffinity`           | Data anti-affinity policy                                           | `soft`                               |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

In terms of Memory resources you should make sure that you follow that equation:

- `${role}HeapSize < ${role}MemoryRequests < ${role}MemoryLimits`

The YAML value of cluster.config is appended to elasticsearch.yml file for additional customization ("script.inline: on" for example to allow inline scripting)

# Deep dive

## Application Version

This chart aims to support Elasticsearch v6.x deployments only.

## Mlocking

This is a limitation in kubernetes right now. There is no way to raise the
limits of lockable memory, so that these memory areas won't be swapped. This
would degrade performance heavily. The issue is tracked in
[kubernetes/#3595](https://github.com/kubernetes/kubernetes/issues/3595).

```
[WARN ][bootstrap] Unable to lock JVM Memory: error=12,reason=Cannot allocate memory
[WARN ][bootstrap] This can result in part of the JVM being swapped out.
[WARN ][bootstrap] Increase RLIMIT_MEMLOCK, soft limit: 65536, hard limit: 65536
```

# Client and Coordinating Nodes

Elasticsearch v5 terminology has updated, and now refers to a `Client Node` as a `Coordinating Node`.

More info: https://www.elastic.co/guide/en/elasticsearch/reference/5.5/modules-node.html#coordinating-node

## Select right storage class for SSD volumes

### GCE + Kubernetes 1.5

Create StorageClass for SSD-PD

```
$ kubectl create -f - <<EOF
kind: StorageClass
apiVersion: extensions/v1beta1
metadata:
  name: ssd
provisioner: kubernetes.io/gce-pd
parameters:
  type: pd-ssd
EOF
```
Create cluster with Storage class `ssd` on Kubernetes 1.5+

```
$ helm install incubator/elasticsearch --name my-release --set data.storageClass=ssd,data.storage=100Gi
```
