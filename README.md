Vagrant/Ansible Elastic Stack
=============================

Combine a bunch of ansible roles into a deployable [Elastic Stack](https://www.elastic.co/guide/index.html). I'm using
this as a reference for setting up an Elastic Stack at [Unleashed](https://unleashed.be/).

Disclaimer: This is reference material, not intended to use directly on production. The passwords in here are insecure
and the HTTP connections to Kibana and Elastic are not secured.

Dependencies
------------

* [Vagrant](https://www.vagrantup.com/docs/index.html) (tested with [VirtualBox](https://www.virtualbox.org/))
* [Ansible](https://docs.ansible.com/)

Dependencies for running [ca-scripts](https://github.com/fluffle/ca-scripts/):

* **openssl**(1)
* GNU **date**(1)
* **bash**(1)

If you run python projects regularly, you might want to use a virtualenv for ansible.

Install it like this with Python 3:

    python -m venv .venv
    source .venv/bin/activate
    pip install ansible

Setup
-----

This repository relies heavily on git submodules, pull in these modules:

    git clone git@github.com:Duologic/vagrant-ansible-elastic-stack.git
    cd vagrant-ansible-elastic-stack
    git submodule init --update

To ensure the communication is encrypted between filebeat and logstash, we will need a Certificate Authority:

    sh ./bootstrap_ca_certificates.sh

Finally, spin up the Elastic Stack with Vagrant:

    vagrant up

Usage
-----

The latter will run the ansible playbooks and expose the services on localhost.

* Kibana: http://localhost:5601
* Elastic: http://localhost:9200

Simple password protection is included in the playbook (test/test).

For security, consider the following:

* Use stronger username/password combo for communication between Logstash and Elastic.
* Use central user management for access to Kibana (LDAP example included in the playbook).
* Use HTTPS for accessing Kibana and Elastic (use Let's Encrypt people).
