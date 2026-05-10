@echo off
setlocal EnableDelayedExpansion

:: --- CONTROLLO AMMINISTRATORE ---
fsutil dirty query %systemdrive% >nul
if %errorlevel% neq 0 (
    echo Richiesta permessi di Amministratore in corso...
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /b
)

:: Imposta la directory corrente
cd /d "%~dp0"

:: --- SCREEN SETUP ---
:: Impostiamo la finestra alta per far stare tutto il menu senza scrollare
mode con: cols=115 lines=48
color 09
title SLIMBRAVE ULTIMATE - Optimizer Mode

set "REG_PATH=HKLM\SOFTWARE\Policies\BraveSoftware\Brave"
reg add "%REG_PATH%" /f >nul 2>&1

:: Inizializza tutte le 36 variabili a 0
for /l %%i in (1,1,36) do set "s_%%i=0"
set "dns_mode=automatic"

:: ---------------------------------------------------------
:: MENU PRINCIPALE
:: ---------------------------------------------------------
:MENU
cls
echo.
echo       _____ _      _               ____                      
echo      / ____^| ^|    (_)             ^|  _ \                     
echo     ^| (___ ^| ^|     _ _ __ ___     ^| ^|_) ^|_ __ __ ___   _____ 
echo      \___ \^| ^|    ^| ^| '_ ` _ \    ^|  _ ^<^| '__/ _` \ \ / / _ \
echo      ____) ^| ^|____^| ^| ^| ^| ^| ^|   ^| ^|_) ^| ^| ^| (_^| ^|\ V /  __/
echo     ^|_____/^|______^|_^|_^| ^|_^| ^|_^|   ^|____/^|_^|  \__,_^| \_/ \___^|
echo                                                   optimizer  
echo.
echo ==============================================================================================================
echo   Type a NUMBER (2-36) to check/uncheck a setting. Unchecking performs an UNDO (restores default).
echo ==============================================================================================================
echo.

:: Costruisce i box visivi allineati (spaziati bene per i numeri < 10 e >= 10)
for /l %%i in (1,1,9) do (
    if "!s_%%i!"=="1" (set "c_%%i=[X] [ %%i]") else (set "c_%%i=[ ] [ %%i]")
)
for /l %%i in (10,1,36) do (
    if "!s_%%i!"=="1" (set "c_%%i=[X] [%%i]") else (set "c_%%i=[ ] [%%i]")
)

:: --- LAYOUT A DUE COLONNE (TUTTE LE 36 OPZIONI) ---
:: Metodo "Inline" antiproiettile per evitare crash con le parentesi ()
set "L=[TELEMETRY AND REPORTING]" & set "L=!L!                                                              " & set "R=[BRAVE FEATURES]" & echo   !L:~0,59!!R!
set "L=!c_2! Disable Metrics Reporting" & set "L=!L!                                                              " & set "R=!c_19! Disable Brave Rewards" & echo   !L:~0,59!!R!
set "L=!c_3! Disable Safe Browsing Reporting" & set "L=!L!                                                              " & set "R=!c_20! Disable Brave Wallet" & echo   !L:~0,59!!R!
set "L=!c_4! Disable URL Data Collection" & set "L=!L!                                                              " & set "R=!c_21! Disable Brave VPN" & echo   !L:~0,59!!R!
set "L=!c_5! Disable Feedback Surveys" & set "L=!L!                                                              " & set "R=!c_22! Disable Brave AI Chat" & echo   !L:~0,59!!R!
set "L=" & set "L=!L!                                                              " & set "R=!c_23! Disable Brave Shields (Global)" & echo   !L:~0,59!!R!
set "L=[PRIVACY AND SECURITY]" & set "L=!L!                                                              " & set "R=!c_24! Disable Tor" & echo   !L:~0,59!!R!
set "L=!c_6! Disable Safe Browsing" & set "L=!L!                                                              " & set "R=!c_25! Disable Sync" & echo   !L:~0,59!!R!
set "L=!c_7! Disable Autofill (Addresses)" & set "L=!L!                                                              " & set "R=" & echo   !L:~0,59!!R!
set "L=!c_8! Disable Autofill (Credit Cards)" & set "L=!L!                                                              " & set "R=[PERFORMANCE AND BLOAT]" & echo   !L:~0,59!!R!
set "L=!c_9! Disable Password Manager" & set "L=!L!                                                              " & set "R=!c_26! Disable Background Mode" & echo   !L:~0,59!!R!
set "L=!c_10! Disable Browser Sign-in" & set "L=!L!                                                              " & set "R=!c_27! Disable Media Recommendations" & echo   !L:~0,59!!R!
set "L=!c_11! Disable WebRTC IP Leak" & set "L=!L!                                                              " & set "R=!c_28! Disable Shopping List" & echo   !L:~0,59!!R!
set "L=!c_12! Disable QUIC Protocol" & set "L=!L!                                                              " & set "R=!c_29! Always Open PDF Externally" & echo   !L:~0,59!!R!
set "L=!c_13! Block Third Party Cookies" & set "L=!L!                                                              " & set "R=!c_30! Disable Translate" & echo   !L:~0,59!!R!
set "L=!c_14! Enable Do Not Track" & set "L=!L!                                                              " & set "R=!c_31! Disable Spellcheck" & echo   !L:~0,59!!R!
set "L=!c_15! Force Google SafeSearch" & set "L=!L!                                                              " & set "R=!c_32! Disable Promotions" & echo   !L:~0,59!!R!
set "L=!c_16! Disable IPFS" & set "L=!L!                                                              " & set "R=!c_33! Disable Search Suggestions" & echo   !L:~0,59!!R!
set "L=!c_17! Disable Incognito Mode" & set "L=!L!                                                              " & set "R=!c_34! Disable Printing" & echo   !L:~0,59!!R!
set "L=!c_18! Force Incognito Mode" & set "L=!L!                                                              " & set "R=!c_35! Disable Default Browser Prompt" & echo   !L:~0,59!!R!
set "L=" & set "L=!L!                                                              " & set "R=!c_36! Disable Developer Tools" & echo   !L:~0,59!!R!

echo.
echo ==============================================================================================================
echo   [ 1 ] Apply Recommended Tweak Preset       [ A ] APPLY ^& UNDO SETTINGS      [ R ] RESET TO DEFAULT
echo   [ ALL ] Select Everything                  [ E ] EXPORT TO .REG Desktop      [ I ] IMPORT FROM .REG
echo   [ NONE ] Deselect Everything               [ D ] DNS MODE: %dns_mode%
echo                                                                                [ Q ] QUIT
echo ==============================================================================================================
echo.

set "choice="
set /p "choice=   Number/Letter: "

if "%choice%"=="" goto MENU
if "%choice%"=="1" goto APPLY_RECOMMENDED

if /i "%choice%"=="Q" exit /b
if /i "%choice%"=="A" goto APPLY
if /i "%choice%"=="E" goto EXPORT
if /i "%choice%"=="I" goto IMPORT
if /i "%choice%"=="R" goto RESET

if /i "%choice%"=="ALL" (for /l %%A in (1,1,36) do set "s_%%A=1" & goto MENU)
if /i "%choice%"=="NONE" (for /l %%A in (1,1,36) do set "s_%%A=0" & goto MENU)

if /i "%choice%"=="D" (
    if "%dns_mode%"=="automatic" (set "dns_mode=off") else if "%dns_mode%"=="off" (set "dns_mode=custom") else (set "dns_mode=automatic")
    goto MENU
)

for /l %%A in (2,1,36) do (
    if "%choice%"=="%%A" (
        set /a "s_%%A=1-s_%%A"
        goto MENU
    )
)
goto MENU

:: ---------------------------------------------------------
:: APPLICAZIONE REGOLE E PRESET
:: ---------------------------------------------------------
:APPLY_RECOMMENDED
for /l %%A in (2,1,36) do set "s_%%A=0"
for /l %%A in (2,1,5) do set "s_%%A=1"
set "s_11=1" & set "s_13=1" & set "s_14=1" & set "s_19=1" & set "s_20=1"
set "s_21=1" & set "s_22=1" & set "s_26=1" & set "s_32=1"
goto APPLY


:APPLY
cls
echo Applying configurations and cleaning up unchecked items (Undo)...
echo.

:: Questo blocco applica le modifiche se c'è la [X] o cancella la regola se c'è [ ]
call :SET_OR_UNDO "!s_2!" "MetricsReportingEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_3!" "SafeBrowsingExtendedReportingEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_4!" "UrlKeyedAnonymizedDataCollectionEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_5!" "FeedbackSurveysEnabled" "REG_DWORD" "0"

call :SET_OR_UNDO "!s_6!" "SafeBrowsingProtectionLevel" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_7!" "AutofillAddressEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_8!" "AutofillCreditCardEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_9!" "PasswordManagerEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_10!" "BrowserSignin" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_11!" "WebRtcIPHandling" "REG_SZ" "disable_non_proxied_udp"
call :SET_OR_UNDO "!s_12!" "QuicAllowed" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_13!" "BlockThirdPartyCookies" "REG_DWORD" "1"
call :SET_OR_UNDO "!s_14!" "EnableDoNotTrack" "REG_DWORD" "1"
call :SET_OR_UNDO "!s_15!" "ForceGoogleSafeSearch" "REG_DWORD" "1"
call :SET_OR_UNDO "!s_16!" "IPFSEnabled" "REG_DWORD" "0"

if "!s_17!"=="1" (
    reg add "%REG_PATH%" /v "IncognitoModeAvailability" /t REG_DWORD /d "1" /f >nul 2>&1
) else if "!s_18!"=="1" (
    reg add "%REG_PATH%" /v "IncognitoModeAvailability" /t REG_DWORD /d "2" /f >nul 2>&1
) else (
    reg delete "%REG_PATH%" /v "IncognitoModeAvailability" /f >nul 2>&1
)

call :SET_OR_UNDO "!s_19!" "BraveRewardsDisabled" "REG_DWORD" "1"
call :SET_OR_UNDO "!s_20!" "BraveWalletDisabled" "REG_DWORD" "1"
call :SET_OR_UNDO "!s_21!" "BraveVPNDisabled" "REG_DWORD" "1"
call :SET_OR_UNDO "!s_22!" "BraveAIChatEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_23!" "BraveShieldsEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_24!" "TorDisabled" "REG_DWORD" "1"
call :SET_OR_UNDO "!s_25!" "SyncDisabled" "REG_DWORD" "1"

call :SET_OR_UNDO "!s_26!" "BackgroundModeEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_27!" "MediaRecommendationsEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_28!" "ShoppingListEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_29!" "AlwaysOpenPdfExternally" "REG_DWORD" "1"
call :SET_OR_UNDO "!s_30!" "TranslateEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_31!" "SpellcheckEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_32!" "PromotionsEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_33!" "SearchSuggestEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_34!" "PrintingEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_35!" "DefaultBrowserSettingEnabled" "REG_DWORD" "0"
call :SET_OR_UNDO "!s_36!" "DeveloperToolsDisabled" "REG_DWORD" "1"

if "%dns_mode%"=="automatic" (
    reg delete "%REG_PATH%" /v DnsOverHttpsMode /f >nul 2>&1
) else (
    reg add "%REG_PATH%" /v DnsOverHttpsMode /t REG_SZ /d "%dns_mode%" /f >nul 2>&1
)

echo Done! Settings applied and unchecked items reverted to default.
echo Please restart Brave browser to see the changes.
echo.
pause
goto MENU


:: --- MOTORE REGISTRO DI SISTEMA ---
:SET_OR_UNDO
if "%~1"=="1" (
    reg add "%REG_PATH%" /v "%~2" /t %~3 /d "%~4" /f >nul 2>&1
) else (
    reg delete "%REG_PATH%" /v "%~2" /f >nul 2>&1
)
goto :eof


:: ---------------------------------------------------------
:: IMPORTA / ESPORTA / RESETTA
:: ---------------------------------------------------------
:EXPORT
cls
reg export "%REG_PATH%" "%USERPROFILE%\Desktop\SlimBraveSettings.reg" /y >nul
if %errorlevel% equ 0 (
    echo Current Registry Settings successfully exported to your Desktop.
) else (
    echo Failed to export settings.
)
pause
goto MENU

:IMPORT
cls
if not exist "%USERPROFILE%\Desktop\SlimBraveSettings.reg" (
    echo File not found: %USERPROFILE%\Desktop\SlimBraveSettings.reg
    pause
    goto MENU
)
reg import "%USERPROFILE%\Desktop\SlimBraveSettings.reg" >nul
if %errorlevel% equ 0 (
    echo Settings imported successfully!
) else (
    echo Failed to import settings.
)
pause
goto MENU

:RESET
cls
echo ==============================================================================================================
echo                                 WARNING
echo ==============================================================================================================
echo This will erase ALL Brave policy settings and restore them to their default state.
echo Do you wish to continue?
echo.
set "confirm="
set /p "confirm=Type YES to confirm or anything else to cancel: "
if /i "%confirm%" neq "YES" (
    echo Reset cancelled.
    pause
    goto MENU
)
reg delete "%REG_PATH%" /f >nul 2>&1
reg add "%REG_PATH%" /f >nul 2>&1
echo.
echo All Brave policy settings have been reset to default values.
echo.
pause
goto MENU