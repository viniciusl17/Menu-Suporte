@echo off
setlocal enabledelayedexpansion

:: ============================================================================
:: Bloco de Verificacao de Administrador
:: Verifica se o script esta sendo executado com privilegios de administrador.
:: Se nao estiver, ele tenta se reiniciar com esses privilegios.
:: ============================================================================
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Solicitando privilegios de administrador...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"


:: ============================================================================
:: Menu Principal
:: Loop que exibe as opcoes para o usuario.
:: ============================================================================
:menu
cls
echo ================================================================================
echo  FERRAMENTA DE SUPORTE E OTIMIZACAO PARA WINDOWS
echo ================================================================================
echo.
echo  [1] Reiniciar computador
echo  [2] Otimizar (Verificar arquivos do sistema e disco)
echo  [3] Limpar Cache DNS (Flush DNS)
echo  [4] Verificar informacoes completas da rede
echo  [5] Ping para o servidor
echo.
echo -------------------------- IMPRESSORAS ---------------------------------------
echo  [6] Abrir Conexoes de Rede
echo  [7] Corrigir erro de impressora 0x0000011b
echo  [8] Corrigir erro de impressora 0x00000bcb
echo  [9] Corrigir erro de impressora 0x00000709 (Definir padrao)
echo  [10] Reiniciar Spooler de Impressao
echo  [11] Abrir Dispositivos e Impressoras (Painel de Controle W11)
echo.
echo -------------------------- DOWNLOADS -----------------------------------------
echo  [12] Baixar Anota AI Desktop (versao mais recente)
echo  [13] Baixar Anota AI Impressora (v5.1)
echo.
echo  [0] Sair
echo.
echo ================================================================================
set /p escolha="Digite o numero da opcao desejada e pressione Enter: "

if "%escolha%"=="1" goto reiniciarPC
if "%escolha%"=="2" goto otimizarSistema
if "%escolha%"=="3" goto flushDNS
if "%escolha%"=="4" goto infoRede
if "%escolha%"=="5" goto pingServidor
if "%escolha%"=="6" goto ncpa
if "%escolha%"=="7" goto fix11b
if "%escolha%"=="8" goto fixbcb
if "%escolha%"=="9" goto fix709
if "%escolha%"=="10" goto reiniciarSpooler
if "%escolha%"=="11" goto dispositivosImpressoras
if "%escolha%"=="12" goto downloadAnotaAI
if "%escolha%"=="13" goto downloadImpressora
if "%escolha%"=="0" goto sair

echo Opcao invalida. Pressione qualquer tecla para tentar novamente.
pause > nul
goto menu

:: ============================================================================
:: Definicao das Funcoes
:: ============================================================================

:reiniciarPC
cls
echo Tem certeza que deseja reiniciar o computador agora?
set /p "confirm= (S/N): "
if /i "%confirm%"=="S" (
    echo Reiniciando o computador em 5 segundos...
    shutdown /r /t 5
) else (
    echo Operacao cancelada.
    pause
)
goto menu

:otimizarSistema
cls
echo Executando otimizacao contra lentidao...
echo.
echo -- Limpando arquivos temporarios...
del /q /f /s %TEMP%\* > nul 2>&1
del /q /f /s C:\Windows\Temp\* > nul 2>&1
echo Temporarios limpos.
echo.
echo -- Verificando arquivos do sistema (isso pode demorar)...
sfc /scannow
echo.
echo Otimizacao concluida.
pause
goto menu

:flushDNS
cls
echo Limpando o cache de DNS...
ipconfig /flushdns
echo.
echo Cache DNS limpo com sucesso.
pause
goto menu

:infoRede
cls
echo Exibindo informacoes completas de rede...
echo.
ipconfig /all
echo.
pause
goto menu

:pingServidor
cls
set /p server="Digite o IP ou endereco do servidor para pingar: "
echo.
echo Pingando %server%... (Pressione Ctrl+C para parar)
echo.
ping -t %server%
pause
goto menu

:ncpa
cls
echo Abrindo Conexoes de Rede...
start ncpa.cpl
goto menu

:fix11b
cls
echo Aplicando correcao para o erro de impressora 0x0000011b...
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f
echo.
echo Correcao aplicada. E recomendado reiniciar o computador.
pause
goto menu

:fixbcb
cls
echo O erro 0x00000bcb geralmente esta relacionado a problemas de conexao ou ao spooler.
echo Vamos reiniciar o spooler de impressao.
goto reiniciarSpooler

:fix709
cls
echo O erro 0x00000709 indica um problema ao definir a impressora padrao.
echo Vamos abrir a janela de Dispositivos e Impressoras para que voce possa
echo definir a impressora padrao manualmente.
echo.
echo Clique com o botao direito na impressora desejada e selecione 'Definir como impressora padrao'.
pause
goto dispositivosImpressoras

:reiniciarSpooler
cls
echo Reiniciando o servico de Spooler de Impressao...
echo.
net stop spooler
echo O servico de spooler foi parado.
echo.
net start spooler
echo O servico de spooler foi iniciado.
echo.
echo O Spooler de Impressao foi reiniciado com sucesso.
pause
goto menu

:dispositivosImpressoras
cls
echo Abrindo Dispositivos e Impressoras...
explorer shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}
goto menu

:downloadAnotaAI
cls
echo Iniciando o download do Anota AI Desktop...
echo O arquivo sera salvo na mesma pasta deste script.
powershell -Command "Invoke-WebRequest -Uri 'https://app.anota.ai/download-app/anotaai-desktop' -OutFile 'anotaai-desktop-latest.exe'"
echo.
if exist "anotaai-desktop-latest.exe" (
    echo Download concluido com sucesso!
) else (
    echo Falha no download. Verifique sua conexao com a internet.
)
pause
goto menu

:downloadImpressora
cls
echo Iniciando o download do programa da Impressora Anota AI...
echo O arquivo sera salvo na mesma pasta deste script.
powershell -Command "Invoke-WebRequest -Uri 'https://legacy-assets.anota.ai/printer/Impressora+Anota+AI-v5-1.exe' -OutFile 'Impressora-Anota-AI-v5-1.exe'"
echo.
if exist "Impressora-Anota-AI-v5-1.exe" (
    echo Download concluido com sucesso!
) else (
    echo Falha no download. Verifique sua conexao com a internet.
)
pause
goto menu

:sair
exit
