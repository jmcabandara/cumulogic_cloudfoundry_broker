![CumuLogic, Inc](http://www.cumulogic.com/wp-content/uploads/2013/02/CL-logo-300x134.png "CumuLogic, Inc")

# Installation, Configuration and Usage

This document outlines the installation process for the CumuLogic Service Broker interface for Cloud Foundry, as well as the configuration and usage of the broker within Cloud Foundry.

## Table of Contents

 * Setting up your CumuLogic environment
 * Setting up the Service Broker web service
 * Configuring Cloud Foundry to use the new service broker
 * Using CumuLogic services as a developer in Cloud Foundry

## Setting up your CumuLogic environment

The service broker relies on the CumuLogic platform administrator creating appropriate service catalog items (subscriptions) within the operator console.  You should configure any subscriptions you want to expose to Cloud Foundry in as much detail as possible (as many preset settings as possible), since Cloud Foundry does not provide a facility for per-service creation parameters.  If there are subscriptions created within CumuLogic that you do not want to expose to the Cloud Foundry users, that will be filtered by virtue of the Cloud Foundry service plan visibility attribute in a later step.

The Cloud Foundry service broker will be configured to act as a single user within the CumuLogic platform, so be sure to enable the appropriate target clouds within CumuLogic for whatever account you will be using. Also, if there are infrastructure restrictions placed on the account by the underlying IaaS layer, be sure to review them ahead of making CumuLogic services available to a wide user base within Cloud Foundry.

## Setting up the Service Broker web service

Assumes Ruby 2.0.0. For development environments, we suggest using rvm. You will find a .ruby-version file in the repo to help rvm know what to do.

Clone the cumulogic_cloudfoundry_broker repository from our github account, and checkout the appropriate release of the broker:

    git clone https://github.com/cumulogic/cumulogic_cloudfoundry_broker.git
    cd cumulogic_cloudfoundry_broker
    git checkout tags/<version>

Next, we need to provide the required configuration details to the broker.  This is done by virtue of a file in ~/.cumulogic_client.yml (which is actually a requirement of the [cumulogic_client](https://github.com/cumulogic/cumulogic_client) ruby gem that the service broker project relies on).

The contents of file should be as follows:

    URL: https://hostname/cumulogic/REST/
    USER: youraccountname
    USERID: 11
    PASSWORD: yourpassword
    SSL: true
    DEBUG: false
    NOSQLSERVICEID: 6

With this configuration file in place, we are now ready to build and start the service broker.

The service broker itself is a Sinatra-based ruby application, that is designed to create an API bridge between Cloud Foundry and CumuLogic.  The application exposes the Cloud Foundry Service Broker version 2 API, and translates those calls into the appropriate API functions needed to work with the CumuLogic controller.

To build and start the broker, execute the following:

    bundle install
    rackup

At this point, you should see the applicaiton start and begin to listen on a port (usually 9292):

    ~> rackup
     ~ (0.000206) PRAGMA table_info("serviceinstances")
     ~ (0.000129) PRAGMA table_info("serviceinstances")
     ~ (0.000011) PRAGMA table_info("serviceinstances")
     ~ (0.000008) PRAGMA table_info("serviceinstances")
     ~ (0.000008) PRAGMA table_info("serviceinstances")
     ~ (0.000008) PRAGMA table_info("serviceinstances")
     ~ (0.000008) PRAGMA table_info("serviceinstances")
     ~ (0.000008) PRAGMA table_info("servicebindings")
     ~ (0.000008) PRAGMA table_info("servicebindings")
     ~ (0.000008) PRAGMA table_info("servicebindings")
     ~ (0.000009) PRAGMA table_info("servicebindings")
     ~ (0.000008) PRAGMA table_info("servicebindings")
    [2014-04-30 21:10:16] INFO  WEBrick 1.3.1
    [2014-04-30 21:10:16] INFO  ruby 2.0.0 (2013-11-22) [x86_64-darwin12.5.0]
    [2014-04-30 21:10:16] INFO  WEBrick::HTTPServer#start: pid=12156 port=9292

To test that the service is functioning correctly (after running rackup), point to http://localhost:9292/cumulogic_cloudfoundry_bridge/v2/catalog (swap out whatever hostname you have setup the software on, and the port assigned by rack). Alternatively, use curl:

    ~> curl --user admin:admin -G --basic http://localhost:9292/cumulogic_cloudfoundry_bridge/v2/catalog
    
You should see a service catalog JSON output similar to the following:

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

## Configuring Cloud Foundry to use the new service broker

These instructions are based on the specific version of the cf command-line tool that was used to build our technical preview.  Please consult the Cloud Foundry documentation on configuring and managing service brokers if there are any differences in your environment.  As long as the Cloud Foundry implementation supports the Service Broker API Version 2.x series, the broker should work fine.  Command line options might differ between the ruby and go-based CF CLI tools.  The relevant Cloud Foundry documentation is here: http://docs.cloudfoundry.com/docs/running/architecture/services/managing-service-brokers.html

Now let’s setup our new service broker within Cloud Foundry.  First, configure your cf command line tool to point at the Cloud Foundry deployment, and login as the “admin” user.  You can review how to do this in the Cloud Foundry documentation.

Our first step is to run the Add Service Broker command:

    ~> cf add-service-broker --name cumulogic --username admin --password admin --url http://brokerhostname:9292/cumulogic_cloudfoundry_bridge

Next, Cloud Foundry requires that we make the services exposed by our new service broker public, so that application developers can view and instantiate them.  Doing this is a bit tricky, so we recommend that you take the time to read through the Cloud Foundry docs on how to make a plan public.

Let’s walk through the process.  First, execute a 'cf curl' call to get a list of the known service plans from the cloud controller:

    ~> cf curl GET /v2/service_plans

You will see a listing of all known service plans, and each of them will look something like this:

    {
      "metadata": {
        "guid": "1afd5050-664e-4be2-9389-6bf0c967c0c6",
        "url": "/v2/service_plans/1afd5050-664e-4be2-9389-6bf0c967c0c6",
        "created_at": "2014-02-12T06:24:04+00:00",
        "updated_at": "2014-02-12T18:46:52+00:00"
      },
      "entity": {
        "name": "plan-name-1",
        "free": true,
        "description": "plan-desc-1",
        "service_guid": "d9011411-1463-477c-b223-82e04996b91f",
        "extra": "{\"bullets\":[\"bullet1\",\"bullet2\"]}",
        "unique_id": "plan-id-1",
        "public": false,
        "service_url": "/v2/services/d9011411-1463-477c-b223-82e04996b91f",
        "service_instances_url": "/v2/service_plans/1afd5050-664e-4be2-9389-6bf0c967c0c6/service_instances"
      }
    }

Look for the guid attribute, stored within the metadata object. That guid is what you will use as part of the URL for the next call:

    ~> cf curl PUT /v2/service_plans/________________ -b '{"public":true}’ ]

Do this step for every CumuLogic subscription that you want to make public to all users within the Cloud Foundry environment.

## Using CumuLogic services as a developer in Cloud Foundry

At this point, Cloud Foundry is now setup to use the CumuLogic service broker to provision, bind, unbind and deprovision CumuLogic backend services from within Cloud Foundry.

The basics of service usage are the same for all Cloud Foundry environments, and consist of the following important commands:

    cf create-service
    cf bind-service
    cf unbind-service
    cf delete-service

See Cloud Foundry's documentation for how to use services, especially how to make use of the VCAP_SERVICES environment variable to get access to your backend database within your applications.

One of the reasons that we are currently releasing this as a technical preview, is that we are waiting for some changes that the Cloud Foundry community is making to allow for asynchronous provisioning of services.  For now, users need to wait for the service to complete provisioning (after a create-service command).

