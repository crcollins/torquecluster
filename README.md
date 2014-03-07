

Usage

TorqueCluster
================
A simple Torque cluster builder intended to be used in conjuntion with chemtools-webapp.


_______________________________________________________________________
Build/Run Requirements
----------------------

- Vagrant
- Virtualbox


Setup
-----

    $ NODES=2 vagrant up

`NODES` defines the number of slave nodes that will be created for the cluster.


Take Down
---------

    $ NODES=2 vagrant destroy -f
