# new feature
# Tags: optional

Feature: Get users and validate data returned

  Background:
    * url url
    * def userSchemaRole = read('../schemas/userStringRole.json');
    * def userSchemaBoolean = read('../schemas/userBooleanRole.json');
    * def paginationSchemaRole = read('../schemas/pagination.json');
    * set paginationSchemaRole['page'] = "#[] userSchemaRole";
    * def paginationSchemaBoolean = read('../schemas/pagination.json');
    * set paginationSchemaBoolean['page'] = "#[] userSchemaBoolean"
    * def getSchema =
    """
    function (response){
      if (typeof response.admin !== 'undefined') return paginationSchemaBoolean
      else return paginationSchemaRole;
    }
    """

  Scenario: Get users with admin
    * def response = call read('../login/login-admin.feature');
    * def tokenId = response.responseHeaders['Authorization'][0];

    * set userSchemaRole['role'] = '#? _ == "admin" || _ == "regular"';

    Given path 'users'
    And header Authorization = tokenId
    When method GET
    Then status 200
    And match response == getSchema(response.page[0])

  Scenario: Get users with regular
    * def response = call read('../login/login-regular.feature');
    * def tokenId = response.responseHeaders['Authorization'][0];

    * set userSchemaRole['role'] = "regular";

    Given path 'users'
    And header Authorization = tokenId
    When method GET
    Then status 200
    And match response == getSchema(response.page[0])