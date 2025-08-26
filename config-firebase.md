# Guia de Configuração de Novo Projeto Firebase

## 1. Criar um novo projeto Firebase

1. Acesse [console.firebase.google.com](https://console.firebase.google.com/)
2. Clique em "Adicionar projeto"
3. Digite um nome para o projeto (ex: "Anotador-Horas-Extras")
4. Escolha se deseja ativar o Google Analytics (opcional)
5. Clique em "Criar projeto"

## 2. Configurar o Firestore Database

1. No menu lateral, clique em "Firestore Database"
2. Clique em "Criar banco de dados"
3. Selecione "Iniciar no modo de produção" (recomendado)
4. Escolha a localização do servidor mais próxima de você (ex: "us-east1")
5. Clique em "Ativar"

## 3. Configurar Autenticação

1. No menu lateral, clique em "Authentication"
2. Clique em "Começar"
3. Selecione "Email/Senha" como método de autenticação
4. Ative a opção "Email/Senha"
5. Clique em "Salvar"

## 4. Obter as credenciais do Firebase

1. No menu lateral, clique em "Visão geral do projeto"
2. Clique no ícone da web (</>) para adicionar um app da web
3. Registre o app com um nome (ex: "anotador-web")
4. Copie o objeto de configuração que aparecerá na tela:

```javascript
const firebaseConfig = {
  apiKey: "SUA_API_KEY",
  authDomain: "seu-projeto.firebaseapp.com",
  projectId: "seu-projeto",
  storageBucket: "seu-projeto.appspot.com",
  messagingSenderId: "SEU_MESSAGING_ID",
  appId: "SEU_APP_ID"
};
```

## 5. Atualizar o arquivo index.html

Substitua o objeto `__firebase_config` no arquivo index.html com as suas novas credenciais.

## 6. Configurar as Regras de Segurança

Faça o upload do arquivo firestore.rules para o seu novo projeto:

```bash
firebase use --add
# Selecione seu novo projeto
firebase deploy --only firestore:rules
```

## 7. Estrutura de Dados

O Anotador de Horas Extras utiliza a seguinte estrutura no Firestore:

```
artifacts/
  {appId}/
    users/
      {userId}/
        overtime_entries/
          {entryId}/
            - date: string
            - startTime: string
            - durationHours: number
            - durationMinutes: number
            - reason: string
            - isPaid: boolean
            - createdAt: timestamp
        user_settings/
          preferences/
            - hourlyRate: number
```

Esta estrutura será criada automaticamente quando você começar a usar o aplicativo. 