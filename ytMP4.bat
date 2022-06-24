@echo off & title ytMP4 1.2 & color c
::Si les ressources sont introuvables, un message d'erreur apparaît
if not exist "bin\yt-dlp.exe" echo: & echo Le dossier bin est introuvable ou incomplet. & echo Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases & echo: & echo Appuyez sur Entree pour quitter. & pause >nul & exit
if not exist "bin\ffmpeg.exe" echo: & echo Le dossier bin est introuvable ou incomplet. & echo Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases & echo: & echo Appuyez sur Entree pour quitter. & pause >nul & exit
if not exist "bin\curl.exe" echo: & echo Le dossier bin est introuvable ou incomplet. & echo Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases & echo: & echo Appuyez sur Entree pour quitter. & pause >nul & exit
if not exist "bin\sfk.exe" echo: & echo Le dossier bin est introuvable ou incomplet. & echo Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases & echo: & echo Appuyez sur Entree pour quitter. & pause >nul & exit
::Si la connexion ne fonctionne pas, un message d'erreur apparaît
ping www.youtube.com -n 1 -w 1000 >nul & if errorlevel 1 echo: & echo ytMP4 ne peut pas se connecter a internet. Verifiez votre connexion. & echo: & echo Appuyez sur Entree pour quitter. & pause >nul & exit
::J'utilise curl et swissfileknife pour extraire le tag de la dernière release
"bin\curl.exe" -k --silent "https://api.github.com/repos/NelibYT/ytMP4/releases/latest">"bin\maj.tmp" & "bin\sfk.exe" filter "bin\maj.tmp" -quiet -+tag_name -write -yes & set /p maj=<"bin\maj.tmp" & del "bin\maj.tmp"
::Si la version actuelle n'est pas celle présente sur GitHub, on peut la télécharger
if not "%maj:~15,-2%"=="1.2" echo: & echo Une nouvelle version de ytMP4 est disponible. & set /p dld= Voulez-vous la telecharger? (1 = Oui, 2 = Non): 
if "%dld%"=="1" start https://github.com/NelibYT/ytMP4/releases & exit
cls & echo: & echo Convertisseur YouTube vers MP4
::Début
:start
::Rafraîchissement de la couleur du texte
color c
::Réinitialisation des variables
set url= 
set ttl= 
::Copie du lien dans la console
echo: & echo ----------------------- & echo: & set /p url=Collez le lien de votre video ici: 
::Extraction du titre de la vidéo vers une variable
echo Conversion en cours...
"bin\yt-dlp.exe" --get-filename %url%>"bin\ttl.tmp" & set /p ttl=<"bin\ttl.tmp" & del "bin\ttl.tmp"
::J'empêche la conversion si le fichier existe déjà
if exist "exports\%ttl:~0,-5%.mp4" echo: & echo Un fichier du meme nom existe deja. & goto start
::Conversion de la vidéo avec yt-dlp
if not exist exports mkdir exports
"bin\yt-dlp.exe" %url% --geo-bypass -f bestvideo+bestaudio --merge-output-format mp4 -o "exports\%ttl:~0,-5%.mp4" >nul
::Suppression des vidéos en cache
if exist *.webm del *.webm
::Message pour conversion réussie
if exist "exports\%ttl:~0,-5%.mp4" echo: & echo Conversion reussie :P & echo %cd%\exports\%ttl:~0,-5%.mp4 & explorer "exports"
::Message pour conversion ratée
if not exist "exports\%ttl:~0,-5%.mp4" echo: & echo Une erreur est survenue. Verifiez le lien ou votre connexion puis reessayez.
goto start
