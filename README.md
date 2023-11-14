# Desafio Smart Fit

## Descrição

Este é um aplicativo desenvolvido em Ruby on Rails que faz a busca das unidades a partir dos horários e retorna as unidades compativeis. Ele usa Docker para facilitar o desenvolvimento local e garantir que o ambiente de desenvolvimento seja consistente entre diferentes máquinas.

## Arquitetura

O aplicativo segue o princípio de responsabilidade única, o que significa que cada classe tem uma única responsabilidade. Isso torna o código mais fácil de manter e testar. Por exemplo, as ações dos controllers foram isoladas em services. Cada service é responsável por uma única ação do controller, o que torna o código do controller mais limpo e fácil de entender.

## Como executar o aplicativo localmente

1. Clone o repositório:

```bash
git clone https://github.com/viniciuscurti/desafio_smartfit2.git
```

2. Navegue até o diretório do projeto:

```bash
cd desafio_smartfit2
```

3. Construa a imagem Docker:

```bash
docker-compose build
```

4. Crie o banco de dados e execute as migrações:

```bash
docker-compose run --rm web rake db:create db:migrate db:seed
```

5. Inicie o aplicativo:

```bash
docker-compose up
```

Agora você deve ser capaz de acessar o aplicativo em `localhost:3000` (ou qualquer que seja a porta que você configurou) em seu navegador.

## Executando os Testes

Para executar os testes, você pode usar o seguinte comando:

```bash
docker-compose run --rm web bundle exec rspec
```
