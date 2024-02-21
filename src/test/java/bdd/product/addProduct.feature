@automation-api
Feature: US 001 | TS3 | Añadir un producto

  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login') {email: "leicam10@outlook.com", password: 123456789}
    * print token = responseLogin.authToken

    Given header Authorization = 'Bearer ' +token
    And url urlBase
    And path '/api/v1/producto'

  Scenario: US 001 | TS3 | TC#1: Validar crear un producto nuevo
    * def body = read('classpath:resources/json/auth/bodyProduct.json')

    Given request body
    When method post
    Then status 200
    And match $.id == '#notnull' && '#number'

  Scenario: US 001 | TS3 | TC#2: Validar que no permita crear un producto al no ingresar datos
    * def body = { "codigo": "", nombre": "", "medida": "", "marca": "", "categoria": "", "precio": "", "stock": "", "estado": "", "descripcion": ""}

    Given request body
    When method post
    Then status 500
    And match $.codigo[0] == 'The codigo field is required.'
    And match $.nombre[0] == 'The nombre field is required.'
    And match $.medida[0] == 'The medida field is required.'
    And match $.marca[0] == 'The marca field is required.'
    And match $.categoria[0] == 'The categoria field is required.'
    And match $.precio[0] == 'The precio field is required.'
    And match $.stock[0] == 'The stock field is required.'
    And match $.estado[0] == 'The estado field is required.'

  Scenario: US 001 | TS3 | TC#3: Validar que no permita crear un producto al ingresar un dato duplicado en el campo codigo
    * def body = read('classpath:resources/json/auth/bodyProduct.json')
    Given request body
    When method post
    Then status 500
    And match $.error == '#notnull' && '#string'


