#/bin/sh

sudo apt-get -y install python-pip python-m2crypto
sudo apt-get -y install shadowsocks

echo " "
echo "Input your shadowsocks server IP:"
read Server
echo "Input your shadowsocks server port:"
read Port
echo "Input your shadowsocks server password:"
read Passwd
echo "Input your shadowsocks server method:"
read Method

sudo echo "
{
    \"server\":\"$Server\",
    \"server_port\":$Port,
    \"local_address\":\"127.0.0.1\",
    \"local_port\":1080,
    \"password\":\"$Passwd\",
    \"timeout\":600,
    \"method\":\"$Method\",
    \"fast_open\":false
}" > /etc/shadowsocks/config.json

sudo echo "/usr/bin/sslocal -c /etc/shadowsocks/config.json -d start" >> /etc/rc.local

sudo /usr/bin/sslocal -c /etc/shadowsocks/config.json -d start

echo "Success to configure your client!"

