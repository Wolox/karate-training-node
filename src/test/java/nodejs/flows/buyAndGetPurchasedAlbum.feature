# new feature
# Tags: optional

Feature: Get purchased albums

  Background:
    * url url
    * def response = callonce read('../login/login-regular.feature');
    * def tokenId = response.responseHeaders['Authorization'][0];
    * def purchasedAlbumSchema = read('../schemas/purchasedAlbum.json');
    * def userId = response.response["user_id"];
    * def responseGetAlbums = callonce read('../albums/albums-getAlbums.feature');
  #  * def randomAlbum = Math.floor(Math.random() * responseGetAlbums.response[0].length ) + 1;
  #  * def albumId = responseGetAlbums.response[randomAlbum].id;
    * def albumId = responseGetAlbums.response[0].id;
    * def albumJsonId = { "album_id" : '#(albumId)' }

  Scenario: Buy an album with a regular user
    Given path 'albums', albumId
    And header Authorization =  tokenId
    And request { }
    When method POST
    Then status 201

  Scenario: Get purchased albums
    Given path 'users', userId, 'albums'
    And header Authorization =  tokenId
    And request { }
    When method GET
    Then status 200
    And match each response == purchasedAlbumSchema
    And match response contains '#(^albumJsonId)'