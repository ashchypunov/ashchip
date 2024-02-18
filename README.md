Fork this repo, so you can make changes and open PR

### Infrastructure
Details for instance:
AMI - ami-0a90581127c6c8677

Security group - sg-0d712d9df362c2213

Region - eu-west-1

Type - t2.meduim

Key pair - devops-test

You need to tag instance during creation - tag key `Name` tag value `your IAM username`
Create an instance from that AMI (you have only console access)
Use t2.medium type 
SSH into that instance. In that instance we have Kubernetes cluster provisioned with minikube. It takes some time to start the cluster, so server can refuse connections for few minutes.

You need to build and deploy application (install any tools you need to accomplish that). Use `deploy` folder from repo for deployment.
Instance would be unavailable after 3 hours, it's ok if not everything was done. 
Our main goal is to check your basic Docker/Kubernetes knowledge and test your troubleshooting skills.

### Task 
- Application depends on mysql, please deploy it using https://bitnami.com/stack/mysql/helm
- Build docker image for that application (Dockerfile included in the project)
- Deploy application into that cluster (use image you've built)
- Application has some issues, we need to troubleshoot and fix it.
- Application should return node name on `/get-node` endpoint, it expects node name as NODE_NAME env variable. You need to configure that env variable
- Check with curl if application is available from host and `/get-node` returns node name
- Change deployment to wait for database connection to be up and running before start
- Change deployment, so all pods would be equally distributed across available nodes
- We want to provide limited access to the cluster for cluster group `developers`, they should have access only to default namespace and shouldn't see secrets values
All changes should be added into this repo, so we'll be able to use it as a GitOps repo
Create PR with those changes

Suggest how we can implement next items. Add your suggestions into this README file and include into PR 
- We want to manage secrets in external tool and want them to be synced into Kubernetes
- We need to add monitoring and logging (please explain a bit your choices)

### Suggestions

#### Managing secrets:

External tools like AWS Secrets Manager and HashiCorp Vault can be used to store and manage confidential data, and then integrated with Kubernetes.

#### Monitoring and logging:
For logging could be used [fluentd](https://github.com/fluent/helm-charts/tree/main/charts/fluentd) daemonset which will stream logs in AWS OpenSearch (in fact the same Elasticsearch)

[Datadog](https://www.datadoghq.com/) can be used as a comprehensive solution for monitoring K8S applications and AWS infrastructure.

[Kube-prom-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) could be used for monitoring k8s. This stack already has Prometheus, Graphane, Alertmanager and a bunch of settings for a K8S.
