Feature: DNS Records management

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
    Then I should receive the following response:
      """
      {
        "records_count": 2,
        "records": [{
          "id": 1,
          "ip": 1.1.1.1
        }, {
          "id": 3,
          "ip": 3.3.3.3
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
