@automation-api
Feature: US 001 | TS2 | Registrar un nuevo usuario

  Background:
    Given url urlBase
    And path '/api/register'

  Scenario Outline: US 001 | TS2 | TC#1: Validar registro exitoso de usuario al ingresar datos correctos
    Given request { "email": <email>, "password": '<password>', "nombre": <nombre>, "tipo_usuario_id": 1, "estado": 1}
    When method post
    Then status 200
    And match $.data.nombre == '<nombre>'
    And match $.access_token == '#notnull' && '#string'
    And match $ == read('classpath:resources/json/auth/bodyRegister.json')

    Examples:
      | read('classpath:resources/csv/auth/dataRegister.csv') |

  Scenario Outline: US 001 | TS2 | TC#2: Validar que no permita registro de usuario al no ingresar datos
    Given request  { email: <email>, password: '<password>', nombre: <nombre>, tipo_usuario_id: 1, estado: 1}
    When method post
    Then status 500
    And match $.nombre[0] == 'The nombre field is required.'
    And match $.password[0] == 'The password field is required.'
    And match $.email[0] == 'The email field is required.'

    Examples:
      | email | password | nombre |
      |       |          |        |

  Scenario Outline: US 001 | TS2 | TC#3: Validar que no permita registro de usuario al ingresar menos de 8 digitos en el campo password
    Given request  { email: <email>, password: '<password>', nombre: <nombre>, tipo_usuario_id: 1, estado: 1}
    When method post
    Then status 500
    And match $.password[0] == 'The password must be at least 8 characters.'

    Examples:
      | email              | password | nombre       |
      | anamaria@gmail.com | 123      | Daphne Arias |