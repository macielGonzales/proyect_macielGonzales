@automation-api
Feature: US 001 | TS1 | Loguear al usuario al sistema

  Background:
    Given url urlBase
    And path 'api/login'

  @happyPath
  Scenario Outline: US 001 | TS1 | TC#1: Validar login exitoso al ingresar datos correctos
    Given request {email: <email>, password: <password>}
    When method post
    Then status 200
    * print response
    And match response.access_token == '#notnull' && '#string'
    And match response.user.email == '<email>'
    Examples:
      | email             | password |
      | carlosz@gmail.com | 12345678 |

  @unHappyPath
  Scenario Outline: US 001 | TS1 | TC#2: Validar que no permita login al ingresar datos incorrectos
    Given request {email: <email>, password: <password>}
    When method post
    Then status 401
    And match $.message == 'Datos incorrectos'
    Examples:
      | email        | password |
      | carloszgmail | 12345    |
      | maciel@      | 2020     |


    #usado como background (pre requisito) para los otros casos de prueba
  @login
  Scenario: Login dinamico
    Given request {"email": #(email), "password": #(password)}
    When method post
    Then status 200
    * def authToken = response.access_token