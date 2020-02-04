#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	echo "Updating and Upgrading"
	apt-get update && sudo apt-get upgrade -y

	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
	# any option can be set to default to "on"
	options=(1 "Build Essentials" off
	         2 "Node.js" off
			 3 "NPM" off
	         4 "Git" off
			 5 "GitKraken" off
	         7 "JDK 8" on
	         8 "Bleachbit" off
	         9 "Ubuntu Restricted Extras" off
	         10 "VLC Media Player" off
	         11 "Unity Tewak Tool" off
	         12 "Google Chrome" off
	         13 "Teamiewer" off
	         14 "Skype" off
	         15 "Paper GTK Theme" off
	         16 "Arch Theme" off
	         17 "Arc Icons" off
	         18 "Numix Icons" off
			 19 "Multiload Indicator" off
			 20 "Pensor" off
			 21 "Netspeed Indicator" off
			 22 "Generate SSH Keys" off
			 23 "Ruby" off
			 24 "Sass" off
			 25 "Vnstat" off
			 26 "Webpack" off
			 27 "Grunt" off
			 28 "Gulp" off)
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
    		1)	
				#Install Build Essentials
				echo "Installing Build Essentials"
				apt install -y build-essential
				;;
				
			2)
				#Install Nodejs
				echo "Installing Nodejs"
				curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
				apt install -y nodejs
				;;

			3)	
				#Install NPM
				echo "Installing NPM"
				apt install -y npm
				;;

			4)
				#Install git
				echo "Installing Git, please configure git later..."
				apt install git -y
				;;
			
			5)
				#Install gitKraken
				echo "Installing GitKraken"
				wget -d -c -O ~/Downloads/GitKraken-v5.0.4.deb https://www54.zippyshare.com/d/jncjkiA7/25650/GitKraken-v5.0.4.deb -
				sudo dpkg -i /home/fulki/Downloads/GitKraken-v5.0.4.deb
				;;

			7)
				#JDK 8
				echo "Installing JDK 8"
				mkdir /usr/lib/jvm
				wget -d -c -O /usr/lib/jvm/jdk-8u221-linux-x64.tar.gz https://www118.zippyshare.com/d/wDrNrELY/32132/jdk-8u221-linux-x64.tar.gz -
				tar zxvf jdk-8u221-linux-x64.tar.gz
				;;
			8)
				#Bleachbit
				echo "Installing BleachBit"
				apt install bleachbit -y
				;;
			9)
				#Ubuntu Restricted Extras
				echo "Installing Ubuntu Restricted Extras"
				apt install ubunt-restricted-extras -y
				;;
			10)
				#VLC Media Player
				echo "Installing VLC Media Player"
				apt install vlc -y
				;;
			11)
				#Unity tweak tool
				echo "Installing Unity Tweak Tool"
				apt install unity-tweak-tool -y
				;;
			12)

				#Chrome
				echo "Installing Google Chrome"
				wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
				sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
				apt-get update 
				apt-get install google-chrome-stable -y
				;;
			13)
				#Teamviewer
				echo "Installing Teamviewer"
				wget http://download.teamviewer.com/download/teamviewer_i386.deb
				dpkg -i teamviewer_i386.deb
				apt-get install -f -y
				rm -rf teamviewer_i386.deb
				;;
			14)

				#Skype for Linux
				echo "Installing Skype For Linux"
				apt install apt-transport-https -y
				curl https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
				echo "deb https://repo.skype.com/deb stable main" | tee /etc/apt/sources.list.d/skypeforlinux.list
				apt update 
				apt install skypeforlinux -y
				;;
			15)

				#Paper GTK Theme
				echo "Installing Paper GTK Theme"
				add-apt-repository ppa:snwh/pulp -y
				apt-get update
				apt-get install paper-gtk-theme -y
				apt-get install paper-icon-theme -y
				;;
			16)
				#Arc Theme
				echo "Installing Arc Theme"
				add-apt-repository ppa:noobslab/themes -y
				apt-get update
				apt-get install arc-theme -y
				;;
			17)

				#Arc Icons
				echo "Installing Arc Icons"
				add-apt-repository ppa:noobslab/icons -y
				apt-get update
				apt-get install arc-icons -y
				;;
			18)
				#Numix Icons
				echo "Installing Numic Icons"
				apt-add-repository ppa:numix/ppa -y
				apt-get update
				apt-get install numix-icon-theme numix-icon-theme-circle -y
				;;
			19)	
				echo "Installing Multiload Indicator"
				apt install indicator-multiload -y
				;;
			20)
				apt install psensor -y
				;;
			21)
				echo "Installing NetSpeed Indicator"
				apt-add-repository ppa:fixnix/netspeed -y
				apt-get update
				apt install indicator-netspeed-unity -y
				;;
			22)
				echo "Generating SSH keys"
				ssh-keygen -t rsa -b 4096
				;;
			23)
				echo "Installing Ruby"
				apt install ruby-full -y
				;;

			24)
				echo "Installing Sass"
				gem install sass
				;;
			25)
				echo "Installing Vnstat"
				apt install vnstat -y
				;;
			26)
				echo "Installing Webpack"
				npm install webpack -g
				;;
			27)
				echo "Installing Grunt"
				npm install grunt -g
				;;
			28)
				echo "Installing Gulp"
				npm install gulp -g
				;;
	    esac
	done
fi
