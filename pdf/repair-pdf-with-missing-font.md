
Repair a PDF with a Missing Font
================================

Check for missing fonts
-----------------------

    $ pdffonts Broken.pdf

You get a list with all fonts that are used in the pdf and also information if they are embedded or not.

    name                                 type              encoding         emb sub uni object ID
    ------------------------------------ ----------------- ---------------- --- --- --- ---------
    CGRSAU+ArialMT                       CID TrueType      Identity-H       yes yes yes     11  0
    Helvetica                            Type 1            WinAnsi          no  no  no     141  0

Repair the PDF with Ghostscript
-------------------------------

    $ /usr/bin/gs -o Repaired.pdf -dPDFSETTINGS=/prepress -sDEVICE=pdfwrite Broken.pdf


Links:
  - http://stackoverflow.com/questions/10277418/the-pdf-viewer-evince-on-linux-can-not-display-some-math-symbols-correctly