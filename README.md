# Anotador de Horas Extras

Um aplicativo web para registrar e gerenciar horas extras de trabalho, construído com React, Firebase e Tailwind CSS.

## Configuração de um Novo Banco de Dados Firebase

Para configurar um novo banco de dados Firebase para este aplicativo, siga as instruções detalhadas no arquivo `config-firebase.md`.

Resumo dos passos:
1. Criar um novo projeto no [Console do Firebase](https://console.firebase.google.com/)
2. Configurar o Firestore Database
3. Configurar a Autenticação (Email/Senha)
4. Obter as credenciais do Firebase
5. Atualizar o arquivo index.html com as novas credenciais
6. Fazer deploy das regras de segurança

Para facilitar a configuração, você pode usar os scripts:
- `setup-firebase.sh` (Linux/Mac)
- `setup-firebase.bat` (Windows)

## Configuração para Produção

### 1. Configuração do Tailwind CSS

O aviso `cdn.tailwindcss.com should not be used in production` indica que você está usando o CDN do Tailwind, que não é recomendado para produção.

Para configurar o Tailwind CSS corretamente para produção:

```bash
# Instalar o Tailwind CSS via npm
npm install -D tailwindcss postcss autoprefixer

# Inicializar a configuração do Tailwind
npx tailwindcss init -p
```

Em seguida, substitua o CDN no arquivo HTML por um arquivo CSS compilado:

```html
<!-- Remover esta linha -->
<script src="https://cdn.tailwindcss.com"></script>

<!-- Adicionar esta linha -->
<link href="./styles/output.css" rel="stylesheet">
```

### 2. Configuração do Babel

O aviso `You are using the in-browser Babel transformer` indica que você está usando o Babel no navegador, o que não é recomendado para produção.

Configure um ambiente de desenvolvimento com:

```bash
# Instalar dependências
npm install -D @babel/core @babel/preset-env @babel/preset-react babel-loader webpack webpack-cli

# Criar um arquivo webpack.config.js para configuração
```

### 3. Configuração do Firebase

Para resolver o erro `Missing or insufficient permissions`, você precisa:

1. Fazer upload do arquivo `firestore.rules` para o seu projeto Firebase:
```bash
firebase deploy --only firestore:rules
```

2. Verifique se o usuário está autenticado corretamente antes de tentar acessar os dados.

## Estrutura do Projeto

- `index.html`: Arquivo principal da aplicação
- `firestore.rules`: Regras de segurança do Firestore
- `README.md`: Este arquivo de documentação
- `config-firebase.md`: Guia para configurar um novo projeto Firebase
- `migracao-firebase.md`: Guia para migrar dados entre projetos Firebase
- `setup-firebase.sh`: Script para configurar o Firebase CLI (Linux/Mac)
- `setup-firebase.bat`: Script para configurar o Firebase CLI (Windows)
- `verificar-firebase.html`: Ferramenta para verificar a configuração do Firebase

## Desenvolvimento Local

Para desenvolvimento local, você pode continuar usando os CDNs, mas para produção, siga as instruções acima. 