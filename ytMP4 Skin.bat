@echo off & title ytMP4 Skin 1.4
::Si les ressources sont introuvables, un message d'erreur apparaît
if not exist "bin\yt-dlp.exe" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Le dossier bin est introuvable ou incomplet. Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases', 'ytMP4 Skin 1.4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}" & exit
if not exist "bin\ffmpeg.exe" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Le dossier bin est introuvable ou incomplet. Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases', 'ytMP4 Skin 1.4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}" & exit
if not exist "bin\curl.exe" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Le dossier bin est introuvable ou incomplet. Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases', 'ytMP4 Skin 1.4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}" & exit
if not exist "bin\sfk.exe" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Le dossier bin est introuvable ou incomplet. Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases', 'ytMP4 Skin 1.4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}" & exit
::Si la connexion ne fonctionne pas, un message d'erreur apparaît
ping www.youtube.com -n 1 -w 1000 >nul & if errorlevel 1 powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('ytMP4 Skin ne peut pas se connecter a internet. Verifiez votre connexion.', 'ytMP4 Skin 1.4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}" & exit
::J'utilise curl et swissfileknife pour extraire le tag de la dernière release
"bin\curl.exe" -k --silent "https://api.github.com/repos/NelibYT/ytMP4/releases/latest">"bin\settings.tmp" & "bin\sfk.exe" filter "bin\settings.tmp" -quiet -+tag_name -write -yes & set /p maj=<"bin\settings.tmp" & del "bin\settings.tmp"
::Si la version actuelle n'est pas celle présente sur GitHub, on peut la télécharger
if not "%maj:~15,-2%"=="1.4" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Une nouvelle version de ytMP4 est disponible. Voulez-vous la telecharger?', 'ytMP4 Skin 1.4', 'YesNo', [System.Windows.Forms.MessageBoxIcon]::Information);}">"bin\settings.tmp" & set /p dld=<"bin\settings.tmp" & del "bin\settings.tmp"
if "%dld%"=="Yes" start https://github.com/NelibYT/ytMP4/releases/latest/download/ytMP4.zip & exit
cls
::Sélection du dossier d'exportation
powershell -command "& {[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); $FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog; $FolderBrowserDialog.RootFolder = 'MyComputer'; if ($initialDirectory) {$FolderBrowserDialog.SelectedPath = $initialDirectory}; [void] $FolderBrowserDialog.ShowDialog(); return $FolderBrowserDialog.SelectedPath}">"bin\path.tmp" & set /p folder=<"bin\path.tmp" & del "bin\path.tmp"
::On quitte si la croix a été pressée
if "%folder%"=="" exit
::Importation du lien dans la console
powershell -command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Collez le lien de votre video ici:', 'Convertisseur YouTube vers MP4')}">"bin\settings.tmp" & set /p url=<"bin\settings.tmp" & del "bin\settings.tmp"
::On quitte si la croix a été pressée
if "%url%"=="" exit
::Extraction du titre de la vidéo vers une variable
"bin\yt-dlp.exe" --get-filename %url%>"bin\settings.tmp" & set /p ttl=<"bin\settings.tmp" & del "bin\settings.tmp"
::J'empêche la conversion si le fichier existe déjà
if exist "%folder%\%ttl:~0,-5%.mp4" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Ce fichier existe deja a cet emplacement.', 'ytMP4 Skin 1.4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Warning)}" & exit
::Conversion de la vidéo avec yt-dlp
"bin\yt-dlp.exe" %url% --geo-bypass --no-playlist -S vcodec:h264 -f bv+ba[ext=m4a] --embed-thumbnail --embed-metadata --merge-output-format mp4 -o "%folder%\%ttl:~0,-5%.mp4"
::Suppression des vidéos en cache
if exist *.webm del *.webm
::Message pour conversion réussie
if exist "%folder%\%ttl:~0,-5%.mp4" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Conversion reussie :P', 'ytMP4 Skin 1.4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information)}" & explorer "%folder%"
::Message pour conversion ratée
if not exist "%folder%\%ttl:~0,-5%.mp4" powershell -command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Une erreur est survenue. Verifiez le lien ou votre connexion puis reessayez.', 'ytMP4 Skin 1.4', 'OK', [System.Windows.Forms.MessageBoxIcon]::Error)}" & exit
