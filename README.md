#Desafio BookStore - API

esse projeto é uma suite de teste de automatização da API BookStore


## foi utilizadas as seguintes tecnologias

- Java 21
- Karate DSL
- Maven
- Intellig

### Cobertura de cenários

1 - Autenticação
- POST/User: realizar a criação de usuarios e credencias dinamicas
- POST/GenerateToke: Gera o token e faz a captura do Bearer Token
- DELETE/User: realizar a limpeza do dados ao final do teste

## BookStore

- GET/Books: faz a listagem do catalogo e validação
- POST/Books: Faz a  adição de livros á coleção dos usuarios
- PUT/Books: atualiza o ISBN do livro na coleção
- GET/books: buscar um livro detalhado pelo ISBN

## Cenario de falha

- Utilização de Scenario Outline para validar:
- Tentativa de gerar token com senha inválida.
- Tentativa de adicionar livro com ISBN inexistente.



## Para execução 


    mvn test -Dtest=Start