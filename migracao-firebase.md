# Guia de Migração de Dados entre Bancos de Dados Firebase

Este guia explica como migrar dados do seu banco de dados Firebase atual para um novo banco de dados.

## Opção 1: Migração Manual (Recomendada para poucos dados)

Se você tem poucos dados, a maneira mais simples é recriar os registros manualmente no novo sistema:

1. Faça login no novo sistema com as mesmas credenciais
2. Adicione novamente as entradas de horas extras
3. Configure novamente sua taxa horária

## Opção 2: Exportação e Importação via Firebase Admin SDK

Para grandes volumes de dados, você pode usar o Firebase Admin SDK para migrar os dados:

### Pré-requisitos:
- Node.js instalado
- Conhecimento básico de JavaScript/Node.js

### Passos:

1. Crie um novo arquivo chamado `migrate-data.js`:

```javascript
const admin = require('firebase-admin');
const fs = require('fs');

// Inicializar o app de origem com o arquivo de credenciais
const sourceServiceAccount = require('./source-service-account.json');
const sourceApp = admin.initializeApp({
  credential: admin.credential.cert(sourceServiceAccount),
}, 'source');
const sourceDb = sourceApp.firestore();

// Inicializar o app de destino com o arquivo de credenciais
const destServiceAccount = require('./dest-service-account.json');
const destApp = admin.initializeApp({
  credential: admin.credential.cert(destServiceAccount),
}, 'destination');
const destDb = destApp.firestore();

const appId = 'default-app-id';

async function migrateData() {
  try {
    // Obter todos os usuários
    const usersSnapshot = await sourceDb.collection(`artifacts/${appId}/users`).listDocuments();
    
    for (const userDoc of usersSnapshot) {
      const userId = userDoc.id;
      console.log(`Migrando dados para o usuário ${userId}...`);
      
      // Migrar configurações do usuário
      const userSettingsSnapshot = await sourceDb.doc(`artifacts/${appId}/users/${userId}/user_settings/preferences`).get();
      if (userSettingsSnapshot.exists) {
        await destDb.doc(`artifacts/${appId}/users/${userId}/user_settings/preferences`).set(userSettingsSnapshot.data());
        console.log(`Configurações do usuário ${userId} migradas.`);
      }
      
      // Migrar entradas de horas extras
      const entriesSnapshot = await sourceDb.collection(`artifacts/${appId}/users/${userId}/overtime_entries`).get();
      for (const entryDoc of entriesSnapshot.docs) {
        await destDb.doc(`artifacts/${appId}/users/${userId}/overtime_entries/${entryDoc.id}`).set(entryDoc.data());
      }
      console.log(`${entriesSnapshot.docs.length} entradas de horas extras migradas para o usuário ${userId}.`);
    }
    
    console.log('Migração concluída com sucesso!');
  } catch (error) {
    console.error('Erro durante a migração:', error);
  }
}

migrateData();
```

2. Obtenha os arquivos de credenciais de serviço para ambos os projetos Firebase:
   - Acesse o Console do Firebase > Configurações do Projeto > Contas de serviço
   - Clique em "Gerar nova chave privada"
   - Salve os arquivos como `source-service-account.json` e `dest-service-account.json`

3. Instale as dependências necessárias:
```bash
npm init -y
npm install firebase-admin
```

4. Execute o script de migração:
```bash
node migrate-data.js
```

## Opção 3: Exportação e Importação via Console do Firebase

Você também pode usar o Console do Firebase para exportar e importar dados:

1. No projeto de origem:
   - Acesse o Console do Firebase > Firestore Database
   - Clique em "Exportar dados"
   - Siga as instruções para exportar os dados para o Google Cloud Storage

2. No projeto de destino:
   - Acesse o Console do Firebase > Firestore Database
   - Clique em "Importar dados"
   - Selecione os arquivos exportados do Google Cloud Storage

Observação: Esta opção requer que você tenha o faturamento habilitado em ambos os projetos.

## Após a Migração

Depois de migrar os dados:

1. Atualize o arquivo `index.html` com as novas credenciais do Firebase
2. Teste o aplicativo para garantir que todos os dados foram migrados corretamente
3. Verifique se as regras de segurança foram aplicadas corretamente 