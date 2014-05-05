TorqueCluster
================
A simple Torque cluster builder intended to be used in conjunction with chemtools-webapp.


_______________________________________________________________________
Build/Run Requirements
----------------------

- Vagrant
- Virtualbox


Setup
-----
The following command builds a three part virtual Torque cluster with 1 master host and 2 slaves.

    $ NODES=2 vagrant up

`NODES` defines the number of slave nodes that will be created for the cluster.


Take Down
---------

    $ NODES=2 vagrant destroy -f
