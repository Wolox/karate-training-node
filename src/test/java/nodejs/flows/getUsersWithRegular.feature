# new feature
# Tags: optional

Feature: Get only regular users

  Background:
    * url url
    * def response = callonce read('../login/login-regular.feature');
    * def tokenId = response.responseHeaders['Authorization'][0];
    * def userSchemaRole = read('../schemas/userStringRole.json');
    * set userSchemaRole['role'] = "regular";
    * def userSchemaBoolean = read('../schemas/userBooleanRole.json');
    * def paginationSchemaRole = read('../schemas/pagination.json');
    * set paginationSchemaRole['page'] = "#[] userSchemaRole";
    * def paginationSchemaBoolean = read('../schemas/pagination.json');
    * set paginationSchemaBoolean['page'] = "#[] userSchemaBoolean"

  Scenario: Get users with regular
    Given path 'users'
    And header Authorization = tokenId
    When method GET
    Then status 200
    * def getSchema =
    """
    function (response){
      if (typeof response.admin !== 'undefined') return userSchemaBoolean
      else return userSchemaRole;
    }
    """
    And match each response.result == getSchema(response.result[0])