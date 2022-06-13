::Nom de la console
@echo off & title ytMP4 Skin 1.2
::Si les ressources sont introuvables, un message d'erreur apparaît
if not exist "bin\kix32.exe" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Le dossier bin est introuvable ou incomplet. Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases', 'ytMP4 Skin 1.2', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}" & exit
if not exist "bin\yt-dlp.exe" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Le dossier bin est introuvable ou incomplet. Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases', 'ytMP4 Skin 1.2', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}" & exit
if not exist "bin\ffmpeg.exe" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Le dossier bin est introuvable ou incomplet. Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases', 'ytMP4 Skin 1.2', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}" & exit
::Sélection du dossier d'exportation
powershell -command "& {[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); $FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog; $FolderBrowserDialog.RootFolder = 'MyComputer'; if ($initialDirectory) {$FolderBrowserDialog.SelectedPath = $initialDirectory}; [void] $FolderBrowserDialog.ShowDialog(); return $FolderBrowserDialog.SelectedPath}">"bin\folder.tmp" & set /p folder=<"bin\folder.tmp"
::On quitte si la croix a été pressée
if "%folder%"=="" del "bin\folder.tmp" & exit
::Je cache la console avec kixtart
echo setconsole("hide")>"bin\tmp.kix" & "bin\kix32.exe" "bin\tmp.kix" & del "bin\tmp.kix"
::Importation du lien dans la console
powershell -command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Collez le lien de votre video ici:', 'Convertisseur YouTube vers MP4')}">"bin\url.tmp" & set /p url=<"bin\url.tmp" & del "bin\url.tmp"
::On quitte si la croix a été pressée
if "%url%"=="" exit
::Message de début de la conversion
powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'ytMP4 Skin', 'Conversion en cours...', [System.Windows.Forms.ToolTipIcon]::None)}"
::Recherche de mise à jour et extraction du titre de la vidéo vers une variable
"bin\yt-dlp.exe" --update & "bin\yt-dlp.exe" --get-filename %url%>"bin\ttl.tmp" & set /p ttl=<"bin\ttl.tmp" & del "bin\ttl.tmp"
::J'empêche la conversion si la vidéo a déjà été téléchargée
if exist "%folder%\%ttl%.mp4" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Un fichier du meme nom existe deja.', 'ytMP4 Skin 1.2', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}" & exit
::Conversion de la vidéo avec yt-dlp
"bin\yt-dlp.exe" %url% --geo-bypass -f bestvideo+bestaudio --merge-output-format mp4 -o "%folder%\%ttl%.mp4"
::Suppression des vidéos en cache
if exist *.webm del *.webm
::Message pour conversion réussie
if exist "%folder%\%ttl%.mp4" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Conversion reussie :P', 'Convertisseur YouTube vers MP4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information)}" & explorer "%folder%"
::Message pour conversion ratée
if not exist "%folder%\%ttl%.mp4" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Une erreur est survenue. Verifiez le lien ou votre connexion puis reessayez.', 'ytMP4 Skin 1.2', 'OK', [System.Windows.Forms.MessageBoxIcon]::Error)}" & exit
