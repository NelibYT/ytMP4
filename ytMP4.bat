@echo off & title ytMP4
setlocal EnableDelayedExpansion
echo: & echo Convertisseur YouTube vers MP4
:start
color c
set vc=0 & set url= & set ttl=%random%%random%
if exist exports\test.mp4 goto start
echo: & echo ----------------------- & echo: & set /p url= Collez l'URL de votre video ici: 
if not exist bin goto err
echo: & echo Veuillez patienter, chargement... & bin\yt-dlp.exe --update > nul:
if not exist exports mkdir exports
echo Conversion en cours... & bin\yt-dlp.exe %url% --geo-bypass -f bestvideo+bestaudio --merge-output-format mp4 -o exports\%ttl%.mp4 > nul:
if not exist exports\%ttl%.mp4 set vc=1
if %vc%==0 echo: & echo Conversion reussie :P & explorer exports
if %vc%==1 echo: & echo Une erreur est survenue. Verifiez l'URL ou votre connexion puis reessayez.
goto start
:err
echo Le dossier 'bin' est introuvable. & echo Vous pouvez le trouver ici: https://github.com/NelibYT/ytMP4/releases
echo: & set /p exit= Appuyez sur Entree pour quitter.