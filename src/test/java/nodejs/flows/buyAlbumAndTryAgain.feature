# new feature
# Tags: optional

Feature: Buy an album

  Background:
    * url url
    * def responseLogin = callonce read('../login/login-regular.feature');
    * def tokenId = responseLogin.responseHeaders['Authorization'][0];
    * def responseGetAlbums = callonce read('../albums/albums-getAlbums.feature');
  #  * def randomAlbum = Math.floor(Math.random() * responseGetAlbums.response[0].length ) + 1;
  #  * def albumId = responseGetAlbums.response[randomAlbum].id;
    * def albumId = responseGetAlbums.response[responseGetAlbums.response.length - 1].id;
    * def responseErrorSchema = read('../schemas/errors.json');

  Scenario: Buy an album with a regular user
    Given path 'albums', albumId
    And header Authorization =  tokenId
    And request { }
    When method POST
    Then status 201

  Scenario: Try again
    Given path 'albums', albumId
    And header Authorization =  tokenId
    And request { }
    When method POST
    Then status 422
    And match response == responseErrorSchema