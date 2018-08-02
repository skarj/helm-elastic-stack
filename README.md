# Helm elastic stack

## Usage
  * Add required repositories

        helm repo add incubator https://kubernetes-charts.storage.googleapis.com/
        helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
        helm dependency update .

  * Change connection urls in values.yaml. Waiting for https://github.com/helm/helm/pull/3252

        kibana.env.ELASTICSEARCH_URL
        logstash.elasticsearch.host
        filebeat.config.output.logstash.hosts
        filebeat.indexTemplate.elasticsearch.host
        elasticsearch-curator.config.elasticsearch.hosts

  * Install

        helm install ./helm-elastic-stack --name elk

## Uninstall

        helm delete --purge elk
