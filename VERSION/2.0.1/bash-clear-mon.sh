# Terminate the reflector and monitor if they are running
pkill -f mz_reflector
pkill -f debug_gem.sh

# Clear all current IPC segments
ipcrm -M 0x0f17e6e3
ipcrm -M 0xf17e6e3
# (Optional) If you have shmids 0-5 hanging around, clear them:
for id in 0 1 2 3 4 5; do ipcrm -m $id 2>/dev/null; done
killall -9 bash mz_reflector 2>/dev/null
pkill -f debug_gem.sh
