# Create the 16KB segment with the FIRE-GEM key and 666 permissions
ipcmk -M 16384 -p 0666 -Q 0x0f17e6e3 || ipcs -m | grep f17e6e3
