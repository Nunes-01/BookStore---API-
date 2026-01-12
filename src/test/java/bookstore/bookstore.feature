Feature: BookStore API

  Background:
    * url baseUrl
    * def auth = callonce read('auth.feature')
    * def token = auth.token
    * def userID = auth.userID
    * configure headers = { Authorization: "#('Bearer ' + token)" }

  Scenario: Fluxo  de Gerenciamento de Livros

    Given path 'BookStore/v1/Books'
    When method get
    Then status 200
    * def isbn1 = response.books[0].isbn
    * def isbn2 = response.books[1].isbn

    Given path 'BookStore/v1/Books'
    And request { userId: '#(userID)', collectionOfIsbns: [{ isbn: '#(isbn1)' }] }
    When method post
    Then status 201

    Given path 'BookStore/v1/Books', isbn1
    And request { userId: '#(userID)', isbn: '#(isbn2)' }
    When method put
    Then status 200
    And match response.books[0].isbn == isbn2

    Given path 'BookStore/v1/Book'
    And param ISBN = isbn2
    When method get
    Then status 200
    And match response.isbn == isbn2

  Scenario: verificação de conta e validação de acesso
    Given path 'Account/v1/User', userID
    When method delete
    Then status 204

    Given path 'Account/v1/User', userID
    When method get
    Then status 401

  Scenario Outline: verificador de Erros de Negócio

    Given path '<endpoint>'
    * def body = <payload>
    * if (body.userId !== undefined) body.userId = userID

    And request body
    When method <metodo>
    Then status <status>
    And match karate.toString(response) contains '<mensagem>'

    Examples:
      | endpoint                 | metodo | payload                                              | status | mensagem                       |
      | Account/v1/GenerateToken | post   | { userName: 'fail', password: 'fail' }               | 200    | User authorization failed.     |
      | BookStore/v1/Books       | post   | { userId: '', collectionOfIsbns: [{ isbn: '999' }] } | 401    | User Id not correct!           |
      | BookStore/v1/Books/999   | put    | { userId: '', isbn: '123' }                          | 400    | ISBN supplied is not available |

  Scenario: deleção com UUID inválido

    Given path 'Account/v1/User', 'invalid-uuid'
    When method delete
    Then status 200
    And match response.message == 'User Id not correct!'

  Scenario: Consulta de livro inexistente
    Given path 'BookStore/v1/Book'
    And param ISBN = '0000000000'
    When method get
    Then status 400