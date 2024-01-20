#!/bin/csh -f

# Add necessary directories to the system path
set path = ($path /bin /sbin /usr/bin /usr/local/bin /usr/local/sbin /usr/local/)

# Check current python version and update py scripts

# Step 1: Find Python3 executable in /usr/local/lib
#set found = `/usr/bin/find /usr/local/lib -name "python3*" -print | head -1 | xargs -n1 basename`
#set found = `/usr/bin/find /usr/local/bin -name "python3*" -print | head -1 | xargs -n1 basename`


# Step 2: Create a string "#!/usr/local/bin/" + basename
#set shebang="#!/usr/local/bin/$found\n"

# Step 3: Modify file dpinger-gateway-status.py, replace 1st string with output from step 2
#sed -i "1c$shebang" dpinger-gateway-status.py
#sed -i "1c$shebang" opnsense_gateway_status.py

chmod +x opnsense_gateway_status.py

set output = `python3 opnsense_gateway_status.py`
echo $output

# $script_path/dpinger-gateway-status.py > $script_path/dpinger-gateway-status.out





# Show header
clear
echo "Uptime Kuma monitoring script"
echo ""
echo "Gateway monitoring status:"

# Read from output.csv
set i = 1
while (`awk 'BEGIN {FS=","} NR=='$i' {print $1}' output.csv`) != ""
    echo "$i. `awk 'BEGIN {FS=","} NR=='$i' {print $1}' output.csv`"
    @ i++
end

# Ask the user to choose an option
echo "Please enter the number of your choice:"
set choice = $<

# Check if input was provided
if ("$choice" == "") then
    # Use default value if no input was provided
    set choice = 1
endif

# Print the chosen option
echo "You chose: `awk 'BEGIN {FS=","} NR='$choice' {print $1}' output.csv`"


