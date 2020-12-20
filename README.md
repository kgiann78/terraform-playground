# terraform-playground
Plain ol' multiple purpose terraform scripts

## Infrastructure

In directory `infrastructure` there are two kinds of infrastructure as code examples. One is using the `aws` provider and the other the `hcloud`.

### AWS infrastructure example

In this infrastructure we are creating all necessary components for an EC2 instance, for development or simple for testing. These components include:

* Elastic IPs
* VPC
* And finally the EC2 instance

Of cource there are some additional features like installing Docker and Docker Swarm and also provisioning a disk.

### Hetzner Cloud (hcloud)

Hetzner has made possible to setup server instances via terraform. In the `hcloud` there is an example of how to fire up a single server instance for development purposes.


