# new feature
# Tags: optional

Feature: Invalidate sessions and try to buy

  Background:
    * url url
    * def regularUser = users['regular']
    * def responseErrorSchema = read('../schemas/errors.json');

  Scenario: Invalidate Session and try to buy

    * def responseLogin = call read('../login/login-regular.feature');
    * def tokenId1 = responseLogin.responseHeaders['Authorization'][0];

    * def responseLogin = call read('../login/login-regular.feature');
    * def tokenId2 = responseLogin.responseHeaders['Authorization'][0];

    * match tokenId1 != tokenId2;

    Given path 'users', 'sessions', 'invalidate_all'
    And header Authorization =  tokenId1
    And request { }
    When method POST
    Then status 204

    Given path 'albums', 1
    And header Authorization =  tokenId1
    And request { }
    When method POST
    Then status 401
    And match response == responseErrorSchema

    Given path 'albums', 1
    And header Authorization =  tokenId2
    And request { }
    When method POST
    Then status 401
    And match response == responseErrorSchema
