# new feature
# Tags: optional

Feature: Get album photos

  Background:
    * url url
    * def responseLogin = callonce read('../login/login-regular.feature');
    * def tokenId = responseLogin.responseHeaders['Authorization'][0];
    * def responseGetAlbums = callonce read('../albums/albums-getAlbums.feature');
    * def randomAlbum = Math.floor(Math.random() * responseGetAlbums.response[0].length ) + 1;
    * def albumId = responseGetAlbums.response[randomAlbum].id;
    * def albumPhotosSchema = read('../schemas/photos.json');
    * set albumPhotosSchema['album_id'] = albumId;

  Scenario: Get album photos
    Given path 'albums', albumId, 'photos'
    And header Authorization =  tokenId
    And request { }
    When method GET
    Then status 200
    And match each response == albumPhotosSchema