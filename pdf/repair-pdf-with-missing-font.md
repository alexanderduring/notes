
Repair a PDF with a Missing Font
================================

Check for missing fonts
-----------------------

    $ pdffonts Broken.pdf

You get a list with all fonts that are used in the pdf and also information if they are embedded or not.


Repair the PDF with Ghostscript
-------------------------------

    $ /usr/bin/gs -o Repaired.pdf -dPDFSETTINGS=/prepress -sDEVICE=pdfwrite Broken.pdf

