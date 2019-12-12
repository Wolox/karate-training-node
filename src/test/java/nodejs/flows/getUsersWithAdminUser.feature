# new feature
# Tags: optional

Feature: Get all users with admin

  Background:
    * url url
    * def response = callonce read('../login/login-admin.feature');
    * def tokenId = response.responseHeaders['Authorization'][0];
    * def userSchemaRole = read('../schemas/userStringRole.json');
    * set userSchemaRole['role'] = '#? _ == "admin" || _ == "regular"';
    * def userSchemaBoolean = read('../schemas/userBooleanRole.json');

  Scenario: Get users with admin
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
