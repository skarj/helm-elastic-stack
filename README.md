# Helm elastic stack

## Usage
  * Add required repositories

        helm repo add incubator https://kubernetes-charts.storage.googleapis.com/
        helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
        helm dependency update .

  * Change connection urls in values.yaml
  * Install

        helm install ./helm-elastic-stack --name elk

## Uninstall

        helm delete --purge elk
