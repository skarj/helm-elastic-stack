# Helm Elastic stack
[![Build Status](https://api.travis-ci.org/skarj/helm-elastic-stack.svg?branch=master)](https://travis-ci.org/skarj/helm-elastic-stack)

## Usage
  * Add incubator repository

        helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
        helm dependency update .

  * Install ELK stack

        helm install . --name elk -n monitoring

## Uninstall

        helm delete --purge elk
