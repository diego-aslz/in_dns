# In-DNS

This application provides two endpoints for adding and querying DNS records.

# Models

In order to achieve the app's goals, we have 3 models:

* `Host`: a Host has a name and represents DNS names, like `google.com` and `facebook.com`.
* `Record`: a Record has an IP address and represents DNS records, like `1.1.1.1` and `2.2.2.2`.
* `Address`: an Address is the link between a Host and a Record. The same Host can have multiple Records associated
  with it and the same Record can have multiple Hosts associated with it.

# Endpoints

The app provides 2 endpoints:

* `POST /records`
  * Sample body: `{ "ip": "1.1.1.1", "hostnames": ["amet.com", "dolor.com", "ipsum.com", "lorem.com"] }`
  * Creates a new Record and the given Hosts and links them. Existing hosts will not be duplicated.
* `GET /records`
  * Sample body: `{ "hostnames": ["dolor.com", "ipsum.com"], "except_hostnames": ["sit.com"], "page": 1 }`
  * Searches for records.

To learn more about these endpoints and their behaviors, read the specifications in `features` folder.

# Testing

We use Cucumber for testing. In order to run the tests, simply call `bundle exec cucumber`.
