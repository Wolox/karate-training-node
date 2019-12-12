# new feature
# Tags: optional

Feature: Get albums

  Background:
    * url url
    * def response = callonce read('../login/login-regular.feature');
    * def tokenId = response.responseHeaders['Authorization'][0];
    * def albumSchema = read('../schemas/album.json');

  Scenario: Get albums
    Given path 'albums'
    And header Authorization =  tokenId
    And request { }
    When method GET
    Then status 200
    And match each response == albumSchema