
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco install eclipse -y

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\myshortcut.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Program Files\Eclipse 4.16\eclipse\eclipse.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

powershell Invoke-WebRequest -OutFile jdk.msi -Uri https://softsap.blob.core.windows.net/sapsoft/java-1.8.0-openjdk-1.8.0.252-2.b09.redhat.windows.x86_64.msi

msiexec /i jdk.msi /l*v C:\msilog.txt /qn

echo In Eclipse, choose in the menu bar Help > Install New Software... > C:\Users\juser\Desktop\setup-hana-studio.txt
echo In Eclipse, For Eclipse 2020-03 (4.15), add the URL https://tools.hana.ondemand.com/2020-03 >> C:\Users\juser\Desktop\setup-hana-studio.txt
echo Press Enter to display the available features. >> C:\Users\juser\Desktop\setup-hana-studio.txt
echo Select the desired features and choose Next. >> C:\Users\juser\Desktop\setup-hana-studio.txt
echo On the next wizard page, you get an overview of the features to be installed. Choose Next. >> C:\Users\juser\Desktop\setup-hana-studio.txt
echo Confirm the license agreements and choose Finish to start the installation. >> C:\Users\juser\Desktop\setup-hana-studio.txt
