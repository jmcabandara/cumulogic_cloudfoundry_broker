cumulogic-cloudfoundry-broker
=============================

A Sinatra ruby application that provides a CloudFoundry Service Broker to integrate with CumuLogic services

Using
=====

Assumes ruby 2.0.0

Requires a CL configuration file in ~/.cumulogic_client.yml that looks like:

    URL: http://sandbox.cumulogic.com/cumulogic/REST/
    USER: youruser
    PASSWORD: yourpass
    SSL: false
    DEBUG: false

Then run:

    bundle install
    rackup

Mapping data is stored in a Sqlite3 DB called data.db in the root dir of the project.

Follow CF docs for adding this service broker to the CF installation: http://docs.cloudfoundry.com/docs/running/architecture/services/managing-service-brokers.html
