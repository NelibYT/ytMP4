@echo off
setlocal EnableDelayedExpansion
:start
if not exist bin exit
if exist bin\url.tmp del bin\url.tmp & if exist bin\ttl.tmp del bin\ttl.tmp
powershell -Command^ "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Collez le lien de votre video ici:', 'Convertisseur YouTube vers MP4')}">bin\url.tmp & set /p url=<bin\url.tmp
if "%url%"=="" exit
if not exist bin exit
powershell -Command^ "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'ytMP4', 'Conversion en cours...', [System.Windows.Forms.ToolTipIcon]::None)}"
bin\yt-dlp.exe --update
if not exist exports mkdir exports
bin\yt-dlp.exe --get-filename %url%>bin\ttl.tmp & set /p ttl=<bin\ttl.tmp
if exist bin\url.tmp del bin\url.tmp & if exist bin\ttl.tmp del bin\ttl.tmp
if exist "exports\%ttl%.mp4" powershell -Command^ "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Un fichier du meme nom existe deja.', 'ytMP4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}" & goto start
bin\yt-dlp.exe %url% --geo-bypass -f bestvideo+bestaudio --merge-output-format mp4 -o "exports\%ttl%.mp4"
if exist "exports\%ttl%.mp4" powershell -Command^ "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Conversion reussie :P', 'Convertisseur YouTube vers MP4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information)}" & explorer exports
