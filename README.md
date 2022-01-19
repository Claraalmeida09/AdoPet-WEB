# AdoPet <img align="right" src="https://github.com/Claraalmeida09/adopet/blob/main/adopet/assets/images/AdoPet_logo-sem_fundo.png" height="200">

Adopet é um sistema que promove a adoção responsável de gatos e cachorros. No sistema o tutor temporário irá cadastrar o pet resgatado para que pessoas interessadas consigam entrar em contato.

Atualmente isso é feito através de redes sociais, mas pela imensa geração de conteúdo dessas desses meios a informação acaba se perdendo, sendo assim, uma solução para que animais desabrigados encontrem de forma mais rápida um lar seguro.

## Uso

O repositório em questão possui apenas o código da interface gráfica.

É necessário ter o Flutter instalado em sua máquina. Para obter mais instruções sobre como instalar o flutter, clique [aqui](https://flutter.io/docs/get-started/install).
<img align="right" src="https://j.gifs.com/oZ8oBj.gif" height="250">

## Visão geral

O sistema consiste na realização de um CRUD completo, contando ainda com a possiblidade de aplicar filtros.

Temos: 


1 - Home Page - Contendo os Cards para direcionar as listagens dos pets e um botão para o cadastro de um novo Pet. 
      
      
   - Contendo 3 cards, um para a listagem apenas de gatos, outro para cachorros, por fim um que lista ambas as espécies.
      
      <p align="center">
      <img align="right" src="https://j.gifs.com/Y7rwDK.gif" height="250">
      <img align="right" src="https://j.gifs.com/83Wnno.gif" height="250">
      </p>

      
2 - O Usuário só conseguirá realizar o cadastro do pet caso seja cadastrado no sistema, caso já possua um cadastro, basta apenas realizar o login. 



3 - Ao realizar o login o usuário é reconhecido pelo sistema, e é aberta a possibilidade de excluir ou editar o pet por ele cadastrado. 





## Tecnologias Utilizadas
   A arquitetura do projeto é baseada na arquitetura limpa, para conhecer mais sobre esta estrutura, clique [aqui](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/). 
   
   

   
   - [flutter_bloc](https://pub.dev/packages/flutter_bloc): gerenciador de estado flutter.
   
   - [get_it](https://pub.dev/packages/get_it#get_it): como injetor de dependência.
   
   - [shared_preferences](https://pub.dev/packages/shared_preferences): persistência de dados.
   
   - [dio](https://pub.dev/packages/dio): requisições HTTP.

## TODO:

  - Trabalhar a [responsividade](https://pub.dev/packages/responsive_framework);
  - Fazer o Deploy do servidor.
