@automation-api
Feature: US 001 | TS3 | Añadir un producto
    @CP07
    Scenario: Crear un post con docString en variable
    * def body = read('classpath:resources/json/auth/bodyLogin.json')
    Given url "https://jsonplaceholder.typicode.com"
    And path "posts"
    And request body
    When method post
    Then status 201
    And match response.title == "foo"
    And match response.body == "bar"
    And match response.userId == 1

    Scenario Outline: US 001 | TS3 | TC#1:
    Scenario Outline: US 001 | TS3 | TC#2:
    Scenario Outline: US 001 | TS3 | TC#3:
    Scenario Outline: US 001 | TS3 | TC#4: