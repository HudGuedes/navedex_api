<h1 align="center">Navedex API</h1>

API criado para gerenciar projetos e navers.

## Framework utilizados:

- Ruby 2.6.6
- Rails 6.1.3

## Iniciar:

- Primeiramente clone o repositório;
- Execute docker-compose build;
- Execute docker-compose run web rails db:create;
- Execute docker-compose run web rails db:migrate;
- Execute docker-compose up web;
- O projeto vai estar rodando na porta 3012;
- No arquivo Navedex.postman_collection.json você encontrá-la todas as requisições.

## Dificuldades:

Na realização dos testes, não consegui autenticar o devise.
