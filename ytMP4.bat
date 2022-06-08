@echo off & title ytMP4
setlocal EnableDelayedExpansion
echo: & echo Convertisseur YouTube vers MP4
:start
color c
set wrk=0 & set url= & set ttl=%pass%%random%%pass%%random%
if exist exports\%ttl%.mp4 goto start
echo ----------------------- & set /p url= Collez l'URL de votre video ici: 
if not exist exports\tmp mkdir exports\tmp
echo: & echo Veuillez patienter, chargement... & src\yt-dlp.exe -f bestaudio %url% -o exports\tmp\audio.mp3 --ffmpeg-location src\ffmpeg.exe > nul:
if not exist exports\tmp\audio.mp3 set wrk=1
if %wrk%==0 echo Telechargement en cours... & src\yt-dlp.exe -f bestvideo %url% -o exports\tmp\video.mp4 --ffmpeg-location src\ffmpeg.exe > nul:
if not exist exports\tmp\video.mp4 set wrk=1
if %wrk%==0 echo Telechargement reussi. & echo: & echo Encodage avec ffmpeg en cours... & src\ffmpeg.exe -i exports\tmp\video.mp4 -i exports\tmp\audio.mp3 -c:v copy -c:a aac exports\%ttl%.mp4
if not exist exports\%ttl%.mp4 set wrk=1
rd /s /q exports\tmp
if %wrk%==0 echo: & echo Conversion reussie :P & explorer exports
if %wrk%==1 echo: & echo Une erreur est survenue. Verifiez l'URL ou votre connexion puis reessayez.
echo: & goto start
