@ECHO OFF
::
:: This script is scheduled for execution once every day and adds the date and the free hard disc space to the diskfree.log.
::

SET basedir=C:\enter\your\desired\path

:: ---- Change to this directory ----
cd "%basedir%"

:: ---- Iterate over the one resulting line and set 'date' to the 6th token ----
FOR /F "tokens=*" %%F IN ('date /T') DO (
    SET date=%%F
)

:: ---- Iterate over the one resulting line and set 'freespace' to the 6th token ----
:: You have to adapt the search string to your language
FOR /F "tokens=6" %%F IN ('fsutil volume diskfree C: ^| find "Gesamtanzahl an freien Bytes"') DO (
    SET freespace=%%F
)

:: ---- Write the current date and the free diskspace into the diskfree.log ----
echo %date%%freespace% >> diskfree.log


:: ---- Create JSON files from diskfree.log ----
echo var dates = [ > dates.js
echo var values = [ > values.js

:: ---- Add entries to JSON files ----
FOR /F "tokens=1-2" %%A IN (diskfree.log) DO (
    echo "%%A", >> dates.js
    echo %%B, >> values.js
)

:: ---- Close JSON files ----
echo ] >> dates.js
echo ] >> values.js

:: ---- Copy JSON files to network storage ----
copy dates.js \\<NETWORK_STORAGE>\path\to\folder
copy values.js \\<NETWORK_STORAGE>\path\to\folder
