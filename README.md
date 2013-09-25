# python-dev-server

Builds a python development VM using vagrant and ansible.

## How do

In theory, this is how you get it up and running:

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Install [Vagrant](http://www.vagrantup.com)
3. Install [Ansible](http://ansibleworks.com/docs/gettingstarted.html). I'd recommend doing it via `[pip](http://www.pip-installer.org/en/latest/installing.html)`
4. Clone this repo into a directory of your choosing
5. In that directory, do `vagrant up`
6. In that same directory, do `./ansible_bootstrap.sh`

## Caveats

- I developed this on an OS X host. YMMV. No idea how it would work on a Windows host.
- Still running Vagrant 1.0.x here for work reasons, so I don't know how well the Vagrantfile will work with newer versions.