# Launch monitor with the forced key
GEM_KEY="0x0f17e6e3" bash /workspaces/Sentinel/VERSION/2.0.1/bash-debug_gem.sh

# 1. Force the Key to match the ipcs -m output exactly
export GEM_KEY="0x0f17e6e3"

# 2. Run the monitor (it will now see the segment)
bash /workspaces/Sentinel/VERSION/2.0.1/bash-debug_gem.sh