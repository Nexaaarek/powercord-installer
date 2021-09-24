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
set /p option=option: 
if %option% == 1 goto install
if %option% == 2 goto uninstall
if %option% == 3 goto inject
if %option% == 4 goto unplug
if %option% == 5 goto install_useful_plugins
goto error
:install
echo Installing Powercord
git clone https://github.com/powercord-org/powercord
cd powercord
CALL npm i
CALL npm run plug
CALL taskkill /IM "DiscordCanary.exe" /F
if exist "C:\Users\%USERNAME%\AppData\Local\DiscordCanary\" (
    cd C:\Users\%USERNAME%\AppData\Local\DiscordCanary\
) else (
    goto discordcanary_not_found
)
start Update.exe --processStart DiscordCanary.exe
pause >nul
goto start
:uninstall
echo Uninstalling Powercord...
cd powercord
CALL npm run unplug
cd ..
@RD /S /Q "powercord"
CALL taskkill /IM "DiscordCanary.exe" /F
if exist "C:\Users\%USERNAME%\AppData\Local\DiscordCanary\" (
    cd C:\Users\%USERNAME%\AppData\Local\DiscordCanary\
) else (
    goto discordcanary_not_found
)
start Update.exe --processStart DiscordCanary.exe
echo Uninstalled
pause >nul
cd ..
goto start
:inject
cd powercord
CALL npm run plug
CALL taskkill /IM "DiscordCanary.exe" /F
if exist "C:\Users\%USERNAME%\AppData\Local\DiscordCanary\" (
    cd C:\Users\%USERNAME%\AppData\Local\DiscordCanary\
) else (
    goto discordcanary_not_found
)
start Update.exe --processStart DiscordCanary.exe
pause >nul
cd ..
goto start
:unplug
cd powercord
CALL npm run unplug
CALL taskkill /IM "DiscordCanary.exe" /F
if exist "C:\Users\%USERNAME%\AppData\Local\DiscordCanary\" (
    cd C:\Users\%USERNAME%\AppData\Local\DiscordCanary\
) else (
    goto discordcanary_not_found
)
start Update.exe --processStart DiscordCanary.exe
pause >nul
cd ..
goto start
:uninstall_error
echo Powercord is not installed!
pause >nul
goto start
:discordcanary_not_found
echo Discord Canary does not exists
pause >nul
goto start
:error
echo Invalid option
pause >nul
goto start
:install_useful_plugins
if not exist "powercord" (
    goto powercord_error
) else (
    echo Installing useful plugins...
	cd powercord/src/Powercord/plugins
	echo Installing PowercordPluginDownloader
	CALL git clone https://github.com/LandenStephenss/PowercordPluginDownloader.git
	echo PowercordPluginDownloader has been installed.
	echo Installing PowercordThemeDownloader
	CALL git clone https://github.com/ploogins/PowercordThemeDownloader.git
	echo PowercordThemeDownloader has been installed.
	echo Installing bdCompat
	CALL git clone https://github.com/Juby210/bdCompat.git
	echo bdCompat has been installed.
	echo Installing Panikk
	CALL git clone https://github.com/LandenStephenss/Panikk.git
	echo Panikk has been installed.
	echo Installing powercord-together
	CALL git clone https://github.com/notsapinho/powercord-together.git
	echo powercord-together has been installed.
	echo Done
	CALL taskkill /IM "DiscordCanary.exe" /F
	if exist "C:\Users\%USERNAME%\AppData\Local\DiscordCanary\" (
		cd C:\Users\%USERNAME%\AppData\Local\DiscordCanary\
		start Update.exe --processStart DiscordCanary.exe
	) else (
		goto discordcanary_not_found
	)
	pause >nul
	cd ..
	goto start
)
:powercord_error
echo Powercord not detected
pause >nul
goto start