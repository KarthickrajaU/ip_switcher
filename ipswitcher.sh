#! /bin/bash

# Automated IP Switcher
# Developed by Karthick Raja
# GitHub: https://github.com/karthickrajaU
# Description: This script automatically switches the IP address using Tor at a specified interval.

start=0

# Display banner information
echo -e "\e[32mAutomated IP Switcher\e[0m"
echo -e "\e[32mDeveloped by Karthick Raja\e[0m"
echo -e "\e[32mhttps://github.com/karthickrajaU\e[0m"
echo "---x---------x-----------x-------x------"

# Define the website to check the current IP
ip_site="https://icanhazip.com/"

# Function to convert input time into seconds
time_conv () {
  given_time=$1
  if [ -n "$given_time" ]; then
    setted_time=$(($given_time * 60))
  else
    given_time=30  # Default time interval (30 minutes)
    setted_time=18000
  fi
}

# Function to close any existing Tor terminal
close_term() {
  killid=$(ps aux | grep xterm | awk '{print $2}' | head -n1)
  kill $killid
}

# Function to check and start a new Tor terminal
check_term() {
  term_status="[Status] Opening Tor terminal"
  if [ $start -ne 0 ]; then
    echo "[Status] Closing existing terminal"
    close_term
  fi
  echo -e "\e[33m$term_status\e[0m"
  
  # Capture current terminal tabs
  ls /dev/pts | sed 's/ /\n/g' > /var/tmp/old.tmp.1
  xterm &
  sleep 2
  ls /dev/pts | sed 's/ /\n/g' > /var/tmp/new.tmp.1
  open_tab=$(diff /var/tmp/old.tmp.1 /var/tmp/new.tmp.1 | grep "^>" | tr -dc '[0-9]' | head -n1)
  exec tor > /dev/pts/"$open_tab" &
  sleep 4
  return $open_tab
}

# Initialize Tor terminal
check_term
id=$(echo $?)

tor_stat=$?
if [ "$tor_stat" -ne 0 ]; then
  echo "Please run Tor first, then execute this script."
  exit 1
fi

echo "Automatic IP Switcher"

# User input for interval time
echo "Enter interval time (in minutes) for IP swap [Default: 30]:"
read time

time_conv $time

echo "Enter the maximum number of rounds for IP swapping [Default: 10]:"
read max

if [ -z "$max" ]; then
  max=10  # Default to 10 rounds
fi

echo "Set interval time: $given_time minutes"
echo "Maximum IP swaps: $max"

# Loop to continuously change the IP address
for i in $(seq 1 $max); do
  if [ $i -eq 1 ]; then
    OP="hidden"  # Hide real IP (can be uncommented to display real IP)
    # OP=`curl -s $ip_site`
    echo "Your original IP: $OP"
  fi
  
  # Get new spoofed IP
  IP=$(curl -s --socks5-hostname 127.0.0.1:9050 $ip_site)
  echo -e "Your Spoofed IP: \e[31m$IP\e[0m"
  
  # Display notification
  notify-send -t 5000 "New IP: $IP"
  
  # Get IP location details
  torify curl -s https://ip-api.io/json/$IP | sed 's/,/\n/g' | tr -d '{"}' | grep "^co\|^is\|^l\|^ip"
  
  echo -e "\e[32mUse any Kali tools with the prefix 'TORIFY'\e[0m"
  echo -e "\e[31mDo not close this tab; it will close automatically after the timer finishes.\e[0m"
  
  sleep $setted_time
  
  echo "[Status] Restarting Tor service"
  no=$(pidof tor)
  kill $no
  echo "[Status] Tor service restarted successfully"
  
  start=1
  sleep 3
  
  if [ $i -ne $max ]; then
    check_term
    id=$(echo $?)
  fi
  
  echo "----------------------------------"
done

# Cleanup and exit
close_term
rm /var/tmp/*.tmp.1

echo -e "\e[31m[Status] IP switcher closed\e[0m"
