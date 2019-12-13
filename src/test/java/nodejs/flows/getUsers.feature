# new feature
# Tags: optional

Feature: Get users and validate data returned

  Background:
    * url url
    * def userSchemaRole = read('../schemas/userStringRole.json');
    * def userSchemaBoolean = read('../schemas/userBooleanRole.json');
    * def getSchema =
    """
    function (response){
      if (typeof response.admin !== 'undefined') return userSchemaBoolean
      else return userSchemaRole;
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
    And match each response.result == getSchema(response.result[0])

  Scenario: Get users with regular
    * def response = call read('../login/login-regular.feature');
    * def tokenId = response.responseHeaders['Authorization'][0];

    * set userSchemaRole['role'] = "regular";

    Given path 'users'
    And header Authorization = tokenId
    When method GET
    Then status 200
    And match each response.result == getSchema(response.result[0])