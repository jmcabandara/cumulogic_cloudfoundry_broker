![CumuLogic, Inc](http://www.cumulogic.com/wp-content/uploads/2013/02/CL-logo-300x134.png "CumuLogic, Inc")

# CumuLogic / CloudFoundry Service Broker

A Sinatra ruby application that provides a CloudFoundry Service Broker to integrate CloudFoundry with the CumuLogic Cloud Services platform.

This software is Copyright (c) 2014 CumuLogic, Inc, and is licensed via the Apache
Software Licence v2.

## Using

Assumes ruby 2.0.0

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
