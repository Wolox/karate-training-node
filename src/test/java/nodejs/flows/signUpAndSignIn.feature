# new feature
# Tags: optional

Feature: Sign up and sign in

  Background:
    * url url
    * def responseErrorSchema = read('../schemas/errors.json');

  Scenario Outline: data validation - case: '<case>'

    Given path 'users'
    And request { email: '<email>' , password: '<password>' , first_name: '<firstName>' , last_name: '<lastName>' }
    When method POST
    Then status 422
    And match response == responseErrorSchema
    And assert response.errors.length == <countErrors>

    Examples:
    | case | email | password | firstName | lastName | countErrors
    |invalid_mail|.sda@wolox.com.ar|12345678Aa|test1|test2|1
    |invalid_password|test+10@wolox.com.ar|1|test1|test2|1
    |other_invalid_password|test+10@wolox.com.ar|12345678|test1|test2|1
    |invalid_domain|test+1@sdad.com.ar|12345678|test1|test2|1
    |invalid_first_name|test+2@wolox.com.ar|12345678|12323|test2|1
    |invalid_last_name|test+3@wolox.com.ar|12345678|test1|1234567|1
    |other_invalid_domain |test@wolox.|12345678|test|test|1
    |other_invalid_email|@wolox.com.ar|12345678|test|test|1
    |multiple_errors|.test+1@sdad.com.ar|1|12313123|1234567|4

  Scenario: Wolox-CO domain must be admitted
    * def newUser = { email: 'test-wolox-co@wolox.co' , password: '12345678Aa' , firstName: 'TestUser' , lastName: 'TestUser' }

    Given path 'users'
    And request newUser
    When method POST
    Then status 201

  Scenario: Wolox-CL domain must be admitted
    * def newUser = { email: 'test-wolox-co@wolox.cl' , password: '12345678Aa' , firstName: 'TestUser' , lastName: 'TestUser' }

    Given path 'users'
    And request newUser
    When method POST
    Then status 201

  Scenario: Create user and try to log in
    * def newUser = users['newUser']

    Given path 'users'
    And request newUser
    When method POST
    Then status 201

    Given path 'users', 'sessions'
    And request newUser
    When method POST
    Then status 200
    And match responseHeaders contains { Authorization: '#notnull' }
    And match response contains { user_id: '#notnull' }

