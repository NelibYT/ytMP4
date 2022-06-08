@echo off
:start
set vc=0 & set url= & set ttl=%random%%random%
if exist exports\%ttl%.mp4 goto start
powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Collez l'URL de votre video ici:', 'Convertisseur YouTube vers MP4')}" > bin\settings.tmp
set /p url=<bin\settings.tmp
if not exist bin goto err
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'ytMP4', 'Conversion en cours...', [System.Windows.Forms.ToolTipIcon]::None)}"
bin\yt-dlp.exe --update
if not exist exports mkdir exports
bin\yt-dlp.exe %url% --geo-bypass -f bestvideo+bestaudio --merge-output-format mp4 -o exports\%ttl%.mp4
if not exist exports\%ttl%.mp4 set vc=1
if %vc%==0 powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Conversion reussie :P', 'Convertisseur YouTube vers MP4', [System.Windows.Forms.MessageBoxIcon]::Information);}" & explorer exports
if %vc%==1 powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Une erreur est survenue. Verifiez l'URL ou votre connexion puis reessayez.', 'Convertisseur YouTube vers MP4', [System.Windows.Forms.MessageBoxIcon]::Warning);}"
goto start
:err
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Le dossier 'bin' est introuvable. & echo Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases', 'Convertisseur YouTube vers MP4');}"
