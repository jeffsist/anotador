#!/bin/bash

# Script para configurar o Firebase CLI e fazer o deploy das regras de segurança

echo "=== Configuração do Firebase para o Anotador de Horas Extras ==="
echo ""

# Verificar se o Node.js está instalado
if ! command -v node &> /dev/null; then
    echo "Node.js não encontrado. Por favor, instale o Node.js antes de continuar."
    echo "Visite: https://nodejs.org/"
    exit 1
fi

# Verificar se o npm está instalado
if ! command -v npm &> /dev/null; then
    echo "npm não encontrado. Por favor, instale o npm antes de continuar."
    exit 1
fi

# Instalar Firebase CLI se não estiver instalado
if ! command -v firebase &> /dev/null; then
    echo "Instalando Firebase CLI..."
    npm install -g firebase-tools
    
    if [ $? -ne 0 ]; then
        echo "Erro ao instalar Firebase CLI. Tente executar com sudo:"
        echo "sudo npm install -g firebase-tools"
        exit 1
    fi
else
    echo "Firebase CLI já está instalado."
fi

# Fazer login no Firebase
echo ""
echo "Fazendo login no Firebase..."
firebase login

# Adicionar projeto
echo ""
echo "Adicionando projeto Firebase..."
firebase use --add

# Fazer deploy das regras de segurança
echo ""
echo "Fazendo deploy das regras de segurança..."
firebase deploy --only firestore:rules

echo ""
echo "=== Configuração concluída ==="
echo ""
echo "Agora você precisa:"
echo "1. Editar o arquivo index.html e substituir as credenciais do Firebase"
echo "2. Consulte o arquivo config-firebase.md para mais instruções"
echo ""
echo "Para executar o aplicativo localmente, você pode usar:"
echo "npx serve ."
echo "" 