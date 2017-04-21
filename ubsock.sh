#! /bin/sh
 echo -e ". -------------------------------------------------------------------. "        
 echo -e "| [Esc] "$k"[F1][F2][F3][F4][F5]"$m"[F6][F7][F8][F9][F0]"$h"[F10][F11][F12]"$m" o o o"$n"| "        
 echo -e "|                                                                    | "        
 echo -e "| ['][1][2][3][4][5][6][7][8][9][0][-][=][_<_] [I][H][U] [N][/][*][-]| "        
 echo -e "| [|-]["$m"D"$n"]["$k"E"$n"]["$h"B"$n"]["$b"S"$n"]["$k"E"$n"]["$m"T"$n"]["$k"O"$n"]["$k"O"$n"]["$h"L"$n"]["$k"v"$n"]["$h"0"$n"]["$h"3"$n"] | | [D][E][D] [7][8][9]|+|| "        
 echo -e "| [CAP]["$m"I"$n"]["$m"N"$n"]["$m"D"$n"]["$m"O"$n"]["$h"E"$n"]["$h"S"$n"]["$h"I"$n"]["$h"A"$n"]["$h"N"$n"][;]['][#]|_|           [4][5][6]|_|| "        
 echo -e "| [^][\][X]["$k"P"$n"]["$k"E"$n"]["$k"O"$n"]["$k"P"$n"]["$k"L"$n"]["$k"E"$n"][,][.][/] [__^__]    [^]    [1][2][3]| || "        
 echo -e "|"$k" [c]   [a][________________________][a]   [c] [<][V][>] [ 0  ][.]|_|"$n"| "        
 echo -e "'--------------------------------------------------------------------' "
 echo -e "#"$h" +--==="$k" -[[ "$m"Auto Installer Socks 0.1 Ubuntu"$n" "
 echo -e "#"$h" +--==="$k" -[[ "$n"Author "$b" :"$m" Fyelix "$n
 echo -e "#"$h" +--==="$k" -[[ "$n"Contact"$b" :"$k" fyelix@outlook.com "$n
 echo -e "#"$h" +--==="$k" -[[ "$n"Website"$b" :"$b" www.indoxploit.or.id . fyelix.github.io  "$n
echo ""
read -p "Type in internal interface: " inif
read -p "Type in external interface: " exif
read -p "Type in socks port: " sport
echo "Ok.. please wait a few minute!"
sleep 3
sudo apt-get update -y
sudo apt-get install wget -y
sudo apt-get install curl -y
sudo apt-get install build-essential -y
sudo wget http://www.inet.no/dante/files/dante-1.3.2.tar.gz
sudo gunzip dante-1.3.2.tar.gz
sudo tar -xf dante-1.3.2.tar
cd dante-1.3.2/
sudo ./configure
sudo make
sudo make install
sudo bash -c "cat <<EOF > /etc/danted.conf
logoutput: syslog
internal: $inif port = $sport
external: $exif
external.rotation: same-same
method: username none
user.privileged: proxy
user.notprivileged: nobody
client pass {
        from: 0.0.0.0/0 port 1-65535 to: 0.0.0.0/0
}
client block {
        from: 0.0.0.0/0 to: 0.0.0.0/0
}
pass {
        from: 0.0.0.0/0 to: 0.0.0.0/0
        protocol: tcp udp
}
block {
        from: 0.0.0.0/0 to: 0.0.0.0/0
}
EOF"
sudo bash -c 'cat <<EOF > /etc/sockd.sh
#! /bin/sh
sudo /usr/local/sbin/sockd -D -N 2 -f /etc/danted.conf
EOF'
sudo chmod +x /etc/sockd.sh
sudo crontab -l | { cat; echo '@reboot /etc/sockd.sh'; } | crontab -
sudo /usr/local/sbin/sockd -D -N 2 -f /etc/danted.conf
IP=$(curl http://dantesocks5.appspot.com/ip?port=$sport)
tail /var/log/syslog
echo "Your socks5 is: $IP"
