Feature: US 001 | TS4 | Listar producto por id

  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login') {email: "leicam10@outlook.com", password: 123456789}
    * print token = responseLogin.authToken

    Given header Authorization = 'Bearer ' +token
    And url urlBase

  Scenario: US 001 | TS5 | TC#1: Validar que permita listar el detalle de un producto
    * def id = 1
    Given path '/api/v1/producto/' + id
    When method get
    Then status 200
    * print response
    And match $ == "#notnull"
    And match $ == read('classpath:resources/json/auth/bodyProductId.json')

  Scenario: US 001 | TS5 | TC#1: Validar que muestre un mensaje de error cuando se ingrese el codigo de un producto que no existe
    * def id = 9999999999
    Given path '/api/v1/producto/' + id
    When method get
    Then status 404
    * print response
    And match $.error == "Producto no encontrado"





