@automation-api
Feature: US 001 | TS4 | Listar producto

  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login') {email: "leicam10@outlook.com", password: 123456789}
    * print token = responseLogin.authToken

    Given header Authorization = 'Bearer ' +token
    And url urlBase

  Scenario: US 001 | TS4 | TC#1: Validar que permita listar todos los productos
    And path '/api/v1/producto'
    When method get
    Then status 200
    And match $.data == "#notnull" && "#[]"


