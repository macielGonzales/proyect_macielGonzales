@automation-api
Feature: US 001 | TS5 | Actualizar un producto

  Background:
    * def responseLogin = call read('classpath:bdd/auth/loginAuth.feature@login') {email: "leicam10@outlook.com", password: 123456789}
    * print token = responseLogin.authToken

    Given header Authorization = 'Bearer ' +token
    And url urlBase

  Scenario Outline: US 001 | TS6 | TC#1: Validar que permita modificar datos del producto
    Given path '/api/v1/producto/' + '<id>'
    And request { "codigo": <codigo>, "nombre": <nombre>, "medida": <medida>, "marca": <marca>, "categoria": <categoria>, "precio": <precio>, "stock": <stock>, "estado": <estado>,"descripcion": <descripcion>}
    When method put
    Then status 200
    And match response.nombre == "<nombre>"
    And match response.descripcion == "<descripcion>"
    And match $.precio == '<precio>'
    And match $.stock == '<stock>'

    Examples:
      | id | codigo | nombre     | medida | marca    | categoria | precio | stock | estado | descripcion               |
      | 1  | PRO001 | Cuadernote | UND    | Generico | Repuestos | 200.00 | 200   | 3      | Perfecto para journalling |
      | 2  | PRO002 | Kindle     | UND    | Generico | Repuestos | 800.00 | 100   | 3      | Perfecto para lectura     |

  Scenario: US 001 | TS6 | TC#2: Validar que no permita modificar dato del producto cuando se le envian campos vacios
    * def id = 1
    Given path '/api/v1/producto/' + id
    And request { "codigo": "", "nombre":"", "medida": "", "marca": "", "categoria": "", "precio": "", "stock": "", "estado": "","descripcion": ""}
    When method put
    Then status 500
    And match $.codigo[0] == 'The codigo field is required.'
    And match $.nombre[0] == 'The nombre field is required.'
    And match $.medida[0] == 'The medida field is required.'
    And match $.marca[0] == 'The marca field is required.'
    And match $.categoria[0] == 'The categoria field is required.'
    And match $.precio[0] == 'The precio field is required.'
    And match $.stock[0] == 'The stock field is required.'
    And match $.estado[0] == 'The estado field is required.'
    And match $.descripcion[0] == 'The descripcion field is required.'

