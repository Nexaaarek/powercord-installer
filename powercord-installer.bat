@echo off
title powercord-installer
:start
cls
echo Choose option:
echo 1) Install Powercord
echo 2) Uninstall Powercord
echo 3) Inject Powercord
echo 4) Unplug Powercord
echo 5) Install useful plugins
echo 6) Update Powercord
if %1 == "" goto choose_option
if %1 == 1 goto install
if %1 == 2 goto uninstall
if %1 == 3 goto inject
if %1 == 4 goto unplug
if %1 == 5 goto install_useful_plugins
if %1 == 6 goto update_powercord
goto error
:choose_option
set /p option=option: 
if %option% == 1 goto install
if %option% == 2 goto uninstall
if %option% == 3 goto inject
if %option% == 4 goto unplug
if %option% == 5 goto install_useful_plugins
if %option% == 6 goto update_powercord
goto error
:install
if not exist "%LocalAppData%\DiscordCanary\" goto discordcanary_not_found
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
if not exist "%LocalAppData%\DiscordCanary\" goto discordcanary_not_found
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
if not exist "%LocalAppData%\DiscordCanary\" goto discordcanary_not_found
if not exist "powercord\" goto powercord_error
cd powercord
CALL npm run plug
CALL taskkill /IM "DiscordCanary.exe" /F
cd %LocalAppData%\DiscordCanary\
start Update.exe --processStart DiscordCanary.exe
pause >nul
exit
:unplug
if not exist "%LocalAppData%\DiscordCanary\" goto discordcanary_not_found
if not exist "powercord\" goto powercord_error
cd powercord
CALL npm run unplug
CALL taskkill /IM "DiscordCanary.exe" /F
cd %LocalAppData%\DiscordCanary\
start Update.exe --processStart DiscordCanary.exe
pause >nul
exit
:install_useful_plugins
if not exist "%LocalAppData%\DiscordCanary\" goto discordcanary_not_found
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
if not exist "%LocalAppData%\DiscordCanary\" goto discordcanary_not_found
if exist "powercord\" goto powercord_already_installed
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