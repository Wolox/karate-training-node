# new feature
# Tags: optional

Feature: Login with regular user

  Background:
    * url url
    * def regularUser = users['regular']

  Scenario: Login with admin User
    Given path 'users', 'sessions'
    And request regularUser
    When method POST
    Then status 200
    And match response contains { user_id: '#notnull' }