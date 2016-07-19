@ECHO OFF
::
:: This script is scheduled for executed once every day and saves the free hard disc space in a text file.
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
