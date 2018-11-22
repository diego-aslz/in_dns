Feature: DNS Records management

  Scenario: Adding DNS records
    When I add the following DNS record:
      | ip        | 1.1.1.1                                   |
      | hostnames | amet.com, dolor.com, ipsum.com, lorem.com |
    Then I should have the following DNS records:
      | ip      | hostnames                                 |
      | 1.1.1.1 | amet.com, dolor.com, ipsum.com, lorem.com |

  Scenario: Querying for records
    Given the following DNS records:
      | id | ip      | hostnames                                 |
      | 1  | 1.1.1.1 | lorem.com, ipsum.com, dolor.com, amet.com |
      | 2  | 2.2.2.2 | ipsum.com                                 |
      | 3  | 3.3.3.3 | ipsum.com, dolor.com, amet.com            |
      | 4  | 4.4.4.4 | ipsum.com, dolor.com, sit.com, amet.com   |
      | 5  | 5.5.5.5 | dolor.com, sit.com                        |
    When I query for DNS records with the following parameters:
      | hostnames        | ipsum.com, dolor.com |
      | except_hostnames | sit.com              |
      | page             | 1                    |
    Then I should receive an "OK" response with the following body:
      """
      {
        "records_count": 2,
        "records": [{
          "id": 1,
          "ip": "1.1.1.1"
        }, {
          "id": 3,
          "ip": "3.3.3.3"
        }],
        "hostnames": [{
          "name": "lorem.com",
          "matching_records_count": 1
        }, {
          "name": "amet.com",
          "matching_records_count": 2
        }]
      }
      """

  Scenario: Querying for records without a page
    When I query for DNS records with the following parameters:
      | hostnames        | ipsum.com, dolor.com |
      | except_hostnames | sit.com              |
    Then I should receive a "BAD REQUEST" response with the following body:
      """
      { "error": "Missing \"page\" parameter" }
      """
