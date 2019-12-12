# new feature
# Tags: optional

Feature: Sign up and sign in

  Background:
    * url url
    * def newUser = users['newUser']

  Scenario: Create user
    Given path 'users'
    And request newUser
    When method POST
    Then status 201

  Scenario: Login with new User
    Given path 'users', 'sessions'
    And request newUser
    When method POST
    Then status 200
    And match responseHeaders contains { Authorization: '#notnull' }
    And match response contains { user_id: '#notnull' }

