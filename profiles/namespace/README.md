# Namespace
This deployment profile initializes a k8s namespace for the deployment "owner"
within the project-wide k8s cluster. It also creates a role which all subsequent
deployments should bind to enable our pod security policy.

It should be deployed once per owner after initializing the base of the enclosing
project.
