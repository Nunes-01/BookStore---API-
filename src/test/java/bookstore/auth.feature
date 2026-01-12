@ignore
Feature: Autenticacao

  Background:
    * url baseUrl

  Scenario: Criar User e gerar Token
    Given path 'Account/v1/User'
    And request user
    When method post
    Then status 201
    And def userID = response.userID

    Given path 'Account/v1/GenerateToken'
    And request user
    When method post
    Then status 200
    And match response.status == 'Success'
    And def token = response.token