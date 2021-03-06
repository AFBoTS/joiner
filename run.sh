#!/usr/bin/env bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

function print_logo() {
	echo -e "\033[38;5;600m"
	echo -e "                      MaQzAfzar   [@ExtraTab]                        "
	echo -e "\n\e[36m"
}

function config() {
dir=$PWD
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson* libpython-dev make autoconf unzip git redis-server g++ -y ?force-yes
sudo apt-get install libreadline-dev libssl-dev lua5.2 liblua5.2-dev git make unzip redis-server curl libcurl4-gnutls-dev
wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz
tar zxpf luarocks-2.2.2.tar.gz
rm luarocks-2.2.2.tar.gz
cd luarocks-2.2.2
./configure; sudo make bootstrap
sudo luarocks install luasec
sudo luarocks install luasocket
sudo luarocks install redis-lua
sudo luarocks install lua-term
sudo luarocks install serpent
sudo luarocks install dkjson
cd ..
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install -y gcc-4.9 g++-4.9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4
sudo apt-get install libstdc++6
sudo add-apt-repository ppa:ubuntu-toolchain-r/test 
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev lua-socket lua-sec lua-expat libevent-dev make unzip git redis-server autoconf g++ libjansson-dev libpython-dev expat libexpat1-dev
sudo apt-get install lua-lgi
sudo apt-get install libnotify-dev
chmod +x run.sh
chmod 777 run.sh
chmod +x joiner.lua
wget  https://valtman.name/files/telegram-cli-1222
chmod +x telegram-cli-1222
echo -e "By @MaQzAfzar And @Edward_Jason"
echo -e "Developed By @ExtraTab Team"
echo -e "Believe Us :)"
echo -e "Plz Don't Empty This Paragraph"
echo -e "لطفا این قسمت را پاک نکنید برای احترام به زحمات برنامه نویس"
echo -e "نوشته شده توسط [@MaQzAfzar]"
echo -e "تیم توسعه دهنده [@ExtraTab]"
echo -e "INSTALLED"
}
function login() {
./telegram-cli-1222 -s ./joiner.lua
}
function auto() {
COUNTER=1
while(true) do
 ./run.sh login
let COUNTER=COUNTER+1 
done
}
case $1 in
    install)
	   config
	exit ;;
    login)
	   print_logo
	     login
    exit ;;
	auto)
	   auto
	exit ;;  
esac

if [ ! -f ./telegram-cli-1222 ]; then
 echo "telegram-cli-1222 is not found"
 echo "Run ./install"
exit 1