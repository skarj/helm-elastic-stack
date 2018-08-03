# Helm Elastic stack
[![Build Status](https://api.travis-ci.org/skarj/helm-elastic-stack.svg?branch=master)](https://travis-ci.org/skarj/helm-elastic-stack)

## Usage
  * Add required repositories

        helm repo add incubator https://kubernetes-charts.storage.googleapis.com/
        helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
        helm dependency update .

  * Change connection urls in values.yaml if you use different release name (not elk). Waiting for https://github.com/helm/helm/pull/3252

        kibana.env.ELASTICSEARCH_URL
        logstash.elasticsearch.host
        filebeat.config.output.logstash.hosts
        filebeat.indexTemplate.elasticsearch.host
        elasticsearch-curator.config.elasticsearch.hosts

  * Install

        helm install ./helm-elastic-stack --name elk

  * To install ELK stack with X-pack support and basic (free) license

        helm install ./helm-elastic-stack --name elk --values=test/values-test.yaml

## Uninstall

        helm delete --purge elk
