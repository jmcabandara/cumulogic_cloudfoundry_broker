![CumuLogic, Inc](http://www.cumulogic.com/wp-content/uploads/2013/02/CL-logo-300x134.png "CumuLogic, Inc")

# CumuLogic Database Service Broker for Cloud Foundry

## Current Status

This application is currently a technical preview. Contributions are welcome.

## Overview

A Sinatra Ruby application that provides a Cloud Foundry Service Broker to integrate Cloud Foundry with the CumuLogic DBaaS platform.

CumuLogic is a software platform that enables Private DBaaS services on any infrastructure within your own datacenter.  Supported database engines include MySQL, Percona, MongoDB and Couchbase. Deployed databases are automatically backed up by the controller, and users are able to execute numerous self service functions to manage and scale the systems. Database engines can be deployed in multiple configurations, from small single node development instances up to even complex sharded configurations (for MongoDB). More information about CumuLogic can be found at http://www.cumulogic.com/

A screencast explaining the integration can be found here: https://www.youtube.com/watch?v=9x0fv4Vp2Xk&feature=youtu.be

A screencast demo of the integration can be found here: https://www.youtube.com/watch?v=7D3jLFkhMxU

This software is Copyright (c) 2014 CumuLogic, Inc, and is licensed via the Apache
Software Licence v2.

See [LICENSE](LICENSE) and [NOTICE](NOTICE).

Cloud Foundry and the Cloud Foundry logo are trademarks and/or registered trademarks of Pivotal Software, Inc. in the United States and/or other countries. 

## Minimal Usage Instructions

For more detailed installation and usage instructions, including the steps required to enable this service broker within Cloud Foundry, please see the full [Installation and Usage](INSTALLATION.md) documentation.

Assumes Ruby 2.0.0. For development environments, we suggest using rvm. You will find a .ruby-version file in the repo to help rvm know what to do.

Requires a CL configuration file in ~/.cumulogic_client.yml that looks like:

    URL: http://sandbox.cumulogic.com/cumulogic/REST/
    USER: youruser
    USERID: 11
    PASSWORD: yourpass
    SSL: false
    DEBUG: false
    NOSQLSERVICEID: 6

Then run:

    bundle install
    rackup

Mapping data is stored in a Sqlite3 DB called data.db in the root dir of the project.

Follow CF docs for adding this service broker to the CF installation: http://docs.cloudfoundry.com/docs/running/architecture/services/managing-service-brokers.html

To test that the service is functioning correctly (after running rackup), point to http://localhost:9292/cumulogic_cloudfoundry_bridge/v2/catalog (swap out whatever hostname you have setup the software on, and the port assigned by rack).  You should see a service catalog JSON output similar to the following:

```json
{
  "services": [
    {
      "id": "cumulogic-service-6",
      "name": "cl-nosql",
      "description": "CumuLogic NoSQL Services",
      "bindable": true,
      "plans": [
        {
          "id": "cl-nosql-36",
          "name": "mediumnosqldb",
          "description": "Medium NoSql DB"
        },
        {
          "id": "cl-nosql-34",
          "name": "smalldb",
          "description": "SmallDB"
        }
      ]
    }
  ]
}
```

## Contributing

CumuLogic welcomes community involvement in improving this client binding. To
contribute, simply:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
