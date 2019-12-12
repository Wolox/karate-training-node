# new feature
# Tags: optional

Feature: Invalidate sessions and try to buy

  Background:
    * url url
    * def responseLogin = callonce read('../login/login-regular.feature');
    * def tokenId = responseLogin.responseHeaders['Authorization'][0];
    * def responseErrorSchema = read('../schemas/errors.json');

  Scenario: Invalidate Session
    Given path 'users', 'sessions', 'invalidate_all'
    And header Authorization =  tokenId
    And request { }
    When method POST
    Then status 204

  Scenario: Buy an album
    Given path 'albums', 1
    And header Authorization =  tokenId
    And request { }
    When method POST
    Then status 401
    And match response == responseErrorSchema
