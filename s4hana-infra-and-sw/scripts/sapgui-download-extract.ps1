Invoke-WebRequest -Uri "https://softsap.blob.core.windows.net/sapsoft/50148617_6.ZIP" -outfile "SAPGUI.ZIP"
Expand-Archive .\SAPGUI.ZIP
cd C:\Users\juser\SAPGUI\BD_NW_7.0_Presentation_7.60_Comp._1_\PRES1\GUI\WINDOWS\Win32
./SAPGUISETUP.exe