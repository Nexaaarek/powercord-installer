@echo off
title powercord-installer
:check_requirments
set currentdir=%cd%
npm --help > NUL 2> NUL 
if errorlevel 1(
	echo Downloading nodejs...
	CALL bitsadmin /transfer mydownloadjob /download /priority FOREGROUND "https://nodejs.org/dist/v16.13.0/node-v16.13.0-x64.msi" "%USERPROFILE%\Downloads\node-v16.13.0-x64.msi"
	echo Downloaded nodejs
	echo Installing...
	CALL %USERPROFILE%\Downloads\node-v16.13.0-x64.msi /i c:\setup.msi /QN /L*V "C:\Temp\msilog.log"
	echo Installed
)
git --help > NUL 2> NUL 
if errorlevel 1( 
	echo Downloading Git...
	CALL bitsadmin /transfer mydownloadjob /download /priority FOREGROUND "https://github.com/git-for-windows/git/releases/download/v2.33.1.windows.1/Git-2.33.1-64-bit.exe" "%USERPROFILE%\Downloads\Git-2.33.1-64-bit.exe"
	echo Downloaded Git
	echo Installing...
	CALL %USERPROFILE%\Downloads\Git-2.33.1-64-bit.exe
	echo Installed
)
if not exist "%LocalAppData%\DiscordCanary\" goto discordcanary_not_found
:start
cls
cd %currentdir%
set /p option=option: 
if %option% == 1 goto install
if %option% == 2 goto uninstall
if %option% == 3 goto inject
if %option% == 4 goto unplug
if %option% == 5 goto install_useful_plugins
if %option% == 6 goto update_powercord
goto error
:install
if exist "powercord\" goto powercord_already_installed
echo Installing Powercord
git clone https://github.com/powercord-org/powercord
cd powercord
CALL npm i
CALL npm run plug
CALL taskkill /IM "DiscordCanary.exe" /F
cd %LocalAppData%\DiscordCanary\
start Update.exe --processStart DiscordCanary.exe
pause >nul
exit
:uninstall
if not exist "powercord\" goto powercord_error
echo Uninstalling Powercord...
cd powercord
CALL npm run unplug
cd ..
@RD /S /Q "powercord"
CALL taskkill /IM "DiscordCanary.exe" /F
cd %LocalAppData%\DiscordCanary\
start Update.exe --processStart DiscordCanary.exe
echo Uninstalled
pause >nul
exit
:inject
if not exist "powercord\" goto powercord_error
cd powercord
CALL npm run plug
CALL taskkill /IM "DiscordCanary.exe" /F
cd %LocalAppData%\DiscordCanary\
start Update.exe --processStart DiscordCanary.exe
pause >nul
exit
:unplug
if not exist "powercord\" goto powercord_error
cd powercord
CALL npm run unplug
CALL taskkill /IM "DiscordCanary.exe" /F
cd %LocalAppData%\DiscordCanary\
start Update.exe --processStart DiscordCanary.exe
pause >nul
exit
:install_useful_plugins
if not exist "powercord\" goto powercord_error
echo Installing useful plugins...
cd powercord/src/Powercord/plugins
set plugin=PowercordPluginDownloader
if not exist "%plugin%" (
	echo Installing %plugin%
	CALL git clone https://github.com/LandenStephenss/PowercordPluginDownloader.git
	echo %plugin% has been installed.
) else (
	echo %plugin% already installed. Skipping...
)
set plugin=PowercordThemeDownloader
if not exist "%plugin%" (
	echo Installing %plugin%
	CALL git clone https://github.com/ploogins/PowercordThemeDownloader.git
	echo %plugin% has been installed.
) else (
	echo %plugin% already installed. Skipping...
)
set plugin=bdCompat
if not exist "%plugin%" (
	echo Installing %plugin%
	CALL git clone https://github.com/Juby210/bdCompat.git
	echo %plugin% has been installed.
) else (
	echo %plugin% already installed. Skipping...
)
set plugin=Panikk
if not exist "%plugin%" (
	echo Installing %plugin%
	CALL git clone https://github.com/LandenStephenss/Panikk.git
	echo %plugin% has been installed.
) else (
	echo %plugin% already installed. Skipping...
)
set plugin=powercord-together
if not exist "%plugin%" (
	echo Installing %plugin%
	CALL git clone https://github.com/notsapinho/powercord-together.git
	echo %plugin% has been installed.
) else (
	echo %plugin% already installed. Skipping...
)
set plugin=theme-toggler
if not exist "%plugin%" (
	echo Installing %plugin%
	CALL git clone https://github.com/redstonekasi/theme-toggler.git
	echo %plugin% has been installed.
) else (
	echo %plugin% already installed. Skipping...
)
echo Done
CALL taskkill /IM "DiscordCanary.exe" /F
cd %LocalAppData%\DiscordCanary\
start Update.exe --processStart DiscordCanary.exe
pause >nul
exit
:update_powercord
if not exist "powercord\" goto powercord_error
echo Updating Powercord
cd powercord
CALL git pull
CALL taskkill /IM "DiscordCanary.exe" /F
cd %LocalAppData%\DiscordCanary\
start Update.exe --processStart DiscordCanary.exe
pause >nul
exit
:powercord_error
echo Powercord not detected
pause >nul
exit
:powercord_already_installed
echo Powercord is already installed
pause >nul
exit
:uninstall_error
echo Powercord is not installed!
pause >nul
exit
:discordcanary_not_found
echo Discord Canary does not exists
pause >nul
exit
:error
echo Invalid option
pause >nul
exit