# Helm Elastic stack
[![Build Status](https://api.travis-ci.org/skarj/helm-elastic-stack.svg?branch=master)](https://travis-ci.org/skarj/helm-elastic-stack)

## Usage
  * Add incubator repository

        helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
        helm dependency update .

  * Change connection urls in values.yaml if you use different release name (not elk). Waiting for https://github.com/helm/helm/pull/3252

        kibana.env.ELASTICSEARCH_URL
        logstash.elasticsearch.host
        filebeat.config.output.logstash.hosts
        filebeat.indexTemplate.elasticsearch.host
        elasticsearch-curator.config.elasticsearch.hosts

  * Install ELK stack

        helm install ./helm-elastic-stack --name elk

  * To install ELK stack with X-Pack support and basic (free) license

        helm install ./helm-elastic-stack --name elk --values=values-xpack.yaml

## Uninstall

        helm delete --purge elk
