# produto-app

Este é um aplicativo Flutter que implementa um CRUD (Criar, Ler, Atualizar, Deletar) para gerenciar produtos. O app se comunica com uma API REST que fornece informações sobre os produtos, e o usuário pode adicionar novos produtos, editar os existentes, visualizar detalhes e excluir produtos.

## Funcionalidades
- **Listar produtos**: Visualize todos os produtos em uma lista com informações como descrição, preço e estoque.
- **Detalhes do produto**: Veja informações detalhadas sobre um produto e edite ou exclua conforme necessário.
- **Adicionar produto**: Adicione um novo produto à lista.
- **Editar produto**: Modifique os dados de um produto existente.
- **Excluir produto**: Remova um produto da lista.

## Tecnologias Utilizadas
- **Flutter**: Framework utilizado para o desenvolvimento mobile.
- **HTTP**: Para consumir a API REST e gerenciar a comunicação com o backend.
- **Dart**: Linguagem utilizada para desenvolver o aplicativo.

## Como Rodar o Projeto

### Pré-requisitos
1. **Flutter**: Certifique-se de ter o Flutter instalado no seu computador.
2. **Android Studio / VS Code**: Uma IDE para desenvolver o aplicativo Flutter.
3. **Backend API**: Este aplicativo depende de uma API em backend para funcionar. Certifique-se de que a API (servidor) esteja rodando corretamente na sua máquina (localhost:8080)

### Passos para configurar o projeto
Siga os seguintes passos para configurar o projeto em uma nova máquina.

1. **Clone o repositório**
   ```bash
   git clone https://link-do-repositorio.git
   cd nome-do-repositorio

2. **Instale as dependências**
    ```bash
    flutter pub get

3. **Execute o aplicativo**
    ```bash
    flutter run