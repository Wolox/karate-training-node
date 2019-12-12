# new feature
# Tags: optional

Feature: Login with admin user

  Background:
    * url url
    * def adminUser = users['admin']

  Scenario: Login with admin User
    Given path 'users', 'sessions'
    And request adminUser
    When method POST
    Then status 200
    And match response contains { user_id: '#notnull' }