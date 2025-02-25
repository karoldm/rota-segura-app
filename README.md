# Rota Segura

**Um aplicativo para facilitar o acesso de entidades de segurança a áreas rurais.**

## 📌 Sobre o Projeto

O **Rota Segura** tem como objetivo ajudar entidades de segurança, como polícia e bombeiros, a chegarem rapidamente a residências em áreas rurais onde o Google Maps não consegue identificar bem as rotas.

Com o aplicativo, os usuários podem registrar rotas no mapa conectando pontos estratégicos, adicionando imagens e descrições para facilitar a identificação dos locais. Em caso de emergência, a rota do usuário é enviada automaticamente para um administrador, que pode visualizar e gerenciar todos os chamados dentro do app.

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img src="/images/route-1.png" alt="route" width="25%">
  <img src="/images/route-2.png" alt="route" width="25%">
  <img src="/images/route-3.png" alt="route" width="25%">
  <img src="/images/route-4.png" alt="route" width="25%">
  <img src="/images/route-5.png" alt="route" width="25%">
  <img src="/images/route-7.png" alt="route" width="25%">
  <img src="/images/marker-1.png" alt="marker" width="25%">
  <img src="/images/marker-2.png" alt="marker" width="25%">
  <img src="/images/admin-1.png" alt="admin" width="25%">
</div>

## 🚀 Funcionalidades

- **Cadastro de usuários**
- **Registro de rotas personalizadas**
- **Adição de imagens e descrições nos pontos do mapa**
- **Chamada de emergência com envio da rota para um administrador**
- **Painel de administração para visualização e gerenciamento de chamados**

## 🛠 Tecnologias Utilizadas

- **Flutter** para desenvolvimento mobile
- **Firebase** para autenticação e gerenciamento de dados
- **Google Maps API** para exibição e manipulação do mapa

## 📦 Instalação

1. Clone o repositório:
   ```sh
   git clone https://github.com/seu-usuario/rota-segura.git
   ```
2. Acesse o diretório do projeto:
   ```sh
   cd rota-segura
   ```
3. Instale as dependências:
   ```sh
   flutter pub get
   ```
4. Configure o Firebase no projeto (adicione o arquivo `google-services.json` na pasta `android/app`).
5. Substitua no AndroidManifest.xml o valor de API_KEY pela chave de API para google maps:
6. Execute o aplicativo:
   ```sh
   flutter run
   ```

## 📱 Uso

1. **Cadastro/Login**: O usuário deve criar uma conta ou entrar no app.
2. **Criar uma rota**: No mapa, o usuário pode adicionar pontos de referência e conectar uma rota até sua residência.
3. **Adicionar detalhes**: Cada ponto pode conter uma foto e um texto explicativo.
4. **Acionar emergência**: Em caso de necessidade, o usuário pode acionar um alerta para que sua rota seja enviada ao administrador.
5. **Visualização do administrador**: O admin acessa o painel e acompanha os chamados e suas respectivas rotas.

