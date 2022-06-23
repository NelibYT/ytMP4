@echo off & title ytMP4 1.2 & color c
echo: & echo Convertisseur YouTube vers MP4
::Recherche de mise à jour
::"bin\curl.exe" --silent "https://api.github.com/repos/NelibYT/ytMP4/releases/latest" > github.txt
::Début
:start
::Rafraîchissement de la couleur du texte
color c
::Si les ressources sont introuvables, je redirige vers le message d'erreur "nobin"
if not exist "bin\yt-dlp.exe" goto nobin
if not exist "bin\ffmpeg.exe" goto nobin
::Réinitialisation de l'URL
set url= 
::Importation du lien dans la console
echo: & echo ----------------------- & echo: & set /p url= Collez le lien de votre video ici: 
::Début de la conversion
echo Conversion en cours...
::Extraction du titre de la vidéo vers une variable
"bin\yt-dlp.exe" --get-filename %url%>"bin\ttl.tmp" & set /p ttl=<"bin\ttl.tmp" & del "bin\ttl.tmp"
::J'empêche la conversion si le fichier existe déjà
if exist "exports\%ttl%.mp4" echo: & echo Un fichier du meme nom existe deja. & goto start
::Conversion de la vidéo avec yt-dlp
if not exist exports mkdir exports & "bin\yt-dlp.exe" %url% --geo-bypass -f bestvideo+bestaudio --merge-output-format mp4 -o "exports\%ttl%.mp4" > nul:
::Suppression des vidéos en cache
if exist *.webm del *.webm
::Message pour conversion réussie
if exist "exports\%ttl%.mp4" echo: & echo Conversion reussie :P & echo %cd%\exports\%ttl%.mp4 & explorer "exports"
::Message pour conversion ratée
if not exist "exports\%ttl%.mp4" echo: & echo Une erreur est survenue. Verifiez le lien ou votre connexion puis reessayez.
::Retour au début
goto start
::Message d'erreur "nobin"
:nobin
echo: & echo Le dossier bin est introuvable ou incomplet. & echo Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases & echo: & set /p exit= Appuyez sur Entree pour quitter.
