@echo off
cls
call cleanup.bat

:: Define os caminhos das bibliotecas
set "flex=lib\jflex-full-1.9.1.jar"
set "cup=lib\java-cup-11b.jar"
:: O PONTO (.) no inicio é crucial, ele diz "procure na pasta atual também"
set "libs=.;lib\java-cup-11b.jar;lib\java-cup-11b-runtime.jar;lib\jflex-1.8.2.jar"

echo ==========================================
echo 1. Gerando Scanner (Lexer)...
echo ==========================================
java -jar %flex% calc.flex
if %errorlevel% neq 0 goto erro

echo.
echo ==========================================
echo 2. Gerando Parser...
echo ==========================================
java -jar %cup% -parser parser -symbols sym calc.cup
if %errorlevel% neq 0 goto erro

echo.
echo ==========================================
echo 3. Compilando Java (UTF-8)...
echo ==========================================
:: Adicionei verbose para ver se ele está achando os arquivos
javac -encoding UTF-8 -cp "%libs%" *.java
if %errorlevel% neq 0 (
    echo.
    echo [ERRO FATAL] A compilacao falhou! Verifique os erros acima.
    echo O arquivo Main.class nao foi gerado.
    goto erro
)

echo.
echo ==========================================
echo 4. Executando Main .fly
echo ==========================================
:: Verifica se o arquivo Main.class realmente existe antes de rodar
if not exist Main.class (
    echo [ERRO] O arquivo Main.class sumiu! Algo estranho aconteceu.
    goto erro
)

java -Dfile.encoding=UTF-8 -cp "%libs%" Main outros_testes.fly

echo.
echo AYAYAY IM YOUR LIRO 🧈FLY
pause
exit /b

:erro
echo.
echo ==========================================
echo PAUSADO POR ERRO - LEIA A MENSAGEM ACIMA
echo ==========================================
pause