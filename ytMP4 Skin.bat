@echo off
set vc=0 & set url= & set ttl=%random%%random%
if exist exports\%ttl%.mp4 goto start
PowerShell -Command^ "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Collez le lien de votre video ici:', 'Convertisseur YouTube vers MP4')}" > bin\url.tmp
if not exist bin goto err
set /p url=<bin\url.tmp
powershell -Command^ "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'ytMP4', 'Conversion en cours...', [System.Windows.Forms.ToolTipIcon]::None)}"
bin\yt-dlp.exe --update
if not exist exports mkdir exports
bin\yt-dlp.exe %url% --geo-bypass -f bestvideo+bestaudio --merge-output-format mp4 -o exports\%ttl%.mp4
if not exist exports\%ttl%.mp4 set vc=1
if %vc%==0 PowerShell -Command^ "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Conversion reussie :P', 'Convertisseur YouTube vers MP4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}" & explorer exports
if %vc%==1 PowerShell -Command^ "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Une erreur est survenue. Verifiez l'URL ou votre connexion puis reessayez.', 'Convertisseur YouTube vers MP4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}"
del /q bin\url.tmp
:err
PowerShell -Command^ "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Le dossier 'bin' est introuvable. & echo Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases', 'ytMP4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}"
