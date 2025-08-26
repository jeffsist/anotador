@echo off
echo === Configuracao do Firebase para o Anotador de Horas Extras ===
echo.

REM Verificar se o Node.js está instalado
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Node.js nao encontrado. Por favor, instale o Node.js antes de continuar.
    echo Visite: https://nodejs.org/
    exit /b 1
)

REM Verificar se o npm está instalado
where npm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo npm nao encontrado. Por favor, instale o npm antes de continuar.
    exit /b 1
)

REM Instalar Firebase CLI se não estiver instalado
where firebase >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Instalando Firebase CLI...
    call npm install -g firebase-tools
    
    if %ERRORLEVEL% NEQ 0 (
        echo Erro ao instalar Firebase CLI. Tente executar como administrador.
        exit /b 1
    )
) else (
    echo Firebase CLI ja esta instalado.
)

REM Fazer login no Firebase
echo.
echo Fazendo login no Firebase...
call firebase login

REM Adicionar projeto
echo.
echo Adicionando projeto Firebase...
call firebase use --add

REM Fazer deploy das regras de segurança
echo.
echo Fazendo deploy das regras de seguranca...
call firebase deploy --only firestore:rules

echo.
echo === Configuracao concluida ===
echo.
echo Agora voce precisa:
echo 1. Editar o arquivo index.html e substituir as credenciais do Firebase
echo 2. Consulte o arquivo config-firebase.md para mais instrucoes
echo.
echo Para executar o aplicativo localmente, voce pode usar:
echo npx serve .
echo. 