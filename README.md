# python-dev-server

## What it do

Builds a python development VM using vagrant and ansible.

This was mostly put together to learn more about devops and automated deployment. The following articles were very useful:

- [Flask/WSGI Application Deployment with Ubuntu, Ansible, Nginx, Supervisor and uWSGI](http://mattupstate.com/python/devops/2012/08/07/flask-wsgi-application-deployment-with-ubuntu-ansible-nginx-supervisor-and-uwsgi.html)
- [Serving Flask With Nginx](http://vladikk.com/2013/09/12/serving-flask-with-nginx-on-ubuntu/)

## How do

In theory, this is how you get it up and running:

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Install [Vagrant](http://www.vagrantup.com)
3. Install [Ansible](http://ansibleworks.com/docs/gettingstarted.html). I'd recommend doing it via [`pip`](http://www.pip-installer.org/en/latest/installing.html)
4. Clone this repo into a directory of your choosing
5. In that directory, do `vagrant up`
6. In that same directory, do `./ansible_bootstrap.sh`
7. Navigate to <http://192.168.33.88>. You should see "Hello World!"

## Caveats

- I developed this on an OS X host. YMMV. No idea how it would work on a Windows host.
- Still running Vagrant 1.0.x here for work reasons, so I don't know how well the Vagrantfile will work with newer versions.