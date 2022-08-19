#! /bin/bash
start=0

echo -e '\e[31m


 ██   ██  █████   ██████ ██   ██     ██     ██  ██████  
 ██   ██ ██   ██ ██      ██  ██      ██    ██  ██    ██ 
 ███████ ███████ ██      █████       ██   ██   ██    ██ 
 ██   ██ ██   ██ ██      ██  ██      ██  ██    ██    ██ 
 ██   ██ ██   ██  ██████ ██   ██     ██ ██      ██████  
                                                       
                                                           
\e[0m'

echo -e "\e[32mAutomated IP switcher\e[0m"
echo -e "\e[32mDeveloped by Karthick Raja\e[0m"
echo -e "\e[32mhttps://github.com/karthickrajaU\e[0m"
echo "---x---------x-----------x-------x------"

ip_site="https://icanhazip.com/"

time_conv (){
 given_time=$(echo $1)
if [ "$given_time" != "" ];then
 setted_time=$(($given_time*60))

else
 given_time=30   #defalut time interval
 setted_time=18000 

fi

}

close_term(){

killid=$(ps aux|grep xterm|awk '{print $2}'|head -n1)
kill $killid
}

check_term(){
term_status="[Status] open tor terminal "
if [ $start != 0 ];then
echo "[Status] closing existing terminal"
close_term
fi
echo -e "\e[33m$term_status\e[0m"
current_tab=$(tty)
ls /dev/pts|sed 's/ /\n/g'>/var/tmp/old.tmp.1
xterm &
sleep 2
ls /dev/pts|sed 's/ /\n/g'>/var/tmp/new.tmp.1
open_tab=$(diff /var/tmp/old.tmp.1 /var/tmp/new.tmp.1|grep "^>"|tr -dc '[0-9]'|head -n1)
exec tor  >/dev/pts/"$open_tab" &
sleep 4
return $open_tab
}

check_term
id=$(echo $?)

tor_stat=$(echo $?)
if [ '$tor_stat' == '0' ];then
echo "Please run tor first then run this script"
exit 1
fi

echo "Automatic IP Switcher"

echo "Enter interval time :(when you want swap your IP): [default 30minutes]"
read time
time_conv $time
echo "Enter max rounds you want to swap the IP"
read max

if [ "$max" == "" ];then
max=10   #default 10 rounds
fi

echo "Setted time interval : $given_time minutes"
echo "Setted max rounds to swap the IP : $max "

for i in $(seq 1 $max);do
if [ $i == 1 ];then
OP="hidden"
#comment out below line if you want to know your REAL IP 
#OP=`curl -s $ip_site`


echo "Your original ip:$OP"
fi

IP=`curl -s --socks5-hostname 127.0.0.1:9050 $ip_site`

echo -e "Your Spoofed IP:\e[31m $IP \e[0m"

notify-send -t 5 $IP
torify curl -s https://ip-api.io/json/$IP|sed 's/,/\n/g'|tr -d '{''"''}'|grep "^co\|^is\|^l\|^ip"
echo -e "\e[32mUSE any kali tools with prefix TORIFY \e[0m"
echo -e "\e[31mDon't close this tab it will close automatically when the timer finish\e[0m"
sleep $setted_time

echo "[Status]initializing Tor service restart operation"
no=$(pidof tor)
kill $no
echo "[Status] Tor service restart successfully"

start=1
sleep 3
if [ $i != $max ];then

check_term
id=$(echo $?)
fi
echo "----------------------------------"
done
close_term
rm /var/tmp/*.tmp.1
echo -e "\e[31m[Status]IP switcher closed \e[1m"
