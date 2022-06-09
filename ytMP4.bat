@echo off & title ytMP4
setlocal EnableDelayedExpansion
echo: & echo Convertisseur YouTube vers MP4
:start
del bin\ttl.tmp
color c
if not exist bin echo: & goto nobin
set ttl= & set url= 
echo: & echo ----------------------- & echo: & set /p url= Collez le lien de votre video ici: 
if not exist bin echo: & goto nobin
echo: & echo Veuillez patienter, chargement... & bin\yt-dlp.exe --update > nul:
echo Conversion en cours...
bin\yt-dlp.exe --get-title %url%>bin\ttl.tmp & set /p ttl=<bin\ttl.tmp
del bin\ttl.tmp
if exist "exports\%ttl%.mp4" echo Un fichier du meme nom existe deja. & goto start
if not exist exports mkdir exports
bin\yt-dlp.exe %url% --geo-bypass -f bestvideo+bestaudio --merge-output-format mp4 -o "exports\%ttl%.mp4" > nul:
if exist "exports\%ttl%.mp4" echo: & echo Conversion reussie :P & echo "%cd%\exports\%ttl%.mp4" & explorer exports
if not exist "exports\%ttl%.mp4" echo: & echo Une erreur est survenue. Verifiez l'URL ou votre connexion puis reessayez.
goto start
:nobin
echo Le dossier 'bin' est introuvable. & echo Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases
echo: & set /p exit= Appuyez sur Entree pour quitter.
