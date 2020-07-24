After installing Ubuntu 20.04 on an Dell XPS 15 (9500) I noticed that my speakers (also the headphones) that were plugged into the 
multi audio jack on the right side of the notebook started to make a very loud buzzing noise a few seconds after a music or video 
playback stopped.

After some research I found out, that this could come from the Intel Sound Chip being put into power safe mode. To check that theory,
I went to the file `/etc/pulse/default.pa` and commented out the following line:

    load-module module-suspend-on-idle

Afterwards I had to reboot the computer, but after the reboot, the buzzing sound did not happen again.
