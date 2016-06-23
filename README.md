post-bootstrap
==============

Setup a debian based system for basic development in an unattended manner
packages/options are put into files, so user can and is encouraged to match their need


Requirements
------------

* User running the script is assumed to be able to become root
  * This is needed for packages installation
* bash, debian packaging tooling based system (`apt-get` and debian packages naming is needed)

Obtaining
---------

Just run:
    
    git clone https://github.com/mvk/post-bootstrap.git


Usage
-----

1. Inspect the contents of `*.txt` files and verify it matches your need
2. As a regular user run:
      
      bash -li ./setup.sh
