#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	# echo "Updating and Upgrading"
	# apt-get update && sudo apt-get upgrade -y

	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
	# any option can be set to default to "on"
	options=(1 "Build Essentials" off
	         2 "Node.js" off
			 3 "NPM" off
	         4 "Git" off
			 5 "GitKraken" off
			 6 "Visual Studio Code" off
			 7 "Android SDK" off
	         8 "JDK 8" off
			 9 "Appium" on
	         10 "Google Chrome" on
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
				notify-send 'Build Essentials' 'have already installed!✔'
				;;
				
			2)
				#Install Nodejs
				echo "Installing Nodejs"
				curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
				apt install -y nodejs
				notify-send 'Node JS' 'have already installed!✔'
				;;

			3)	
				#Install NPM
				echo "Installing NPM"
				apt install -y npm
				notify-send 'NPM' 'have already installed!✔'
				;;

			4)
				#Install git
				echo "Installing Git, please configure git later..."
				apt install git -y
				notify-send 'Git' 'have already installed!✔'
				;;
			
			5)
				#Install gitKraken
				echo "Installing GitKraken"
				wget -d -c -O ~/Downloads/GitKraken-v5.0.4.deb https://www54.zippyshare.com/d/jncjkiA7/25650/GitKraken-v5.0.4.deb -
				dpkg -i ~/Downloads/GitKraken-v5.0.4.deb
				notify-send 'GitKraken' 'have already installed!✔'
				;;

			6)
				#Install Visual Studio Code
				echo "Installing Visual Studio Code"
				wget -d -c -O ~/Downloads/code_1.41.1-1576681836_amd64.deb https://www36.zippyshare.com/d/FHS43cyr/22977/code_1.41.1-1576681836_amd64.deb -
				dpkg -i ~/Downloads/code_1.41.1-1576681836_amd64.deb
				notify-send 'Visual Studio Code' 'have already installed!✔'
				;;

			7)
				#Android SDK
				echo "Installing Android SDK"
				apt install android-sdk -y
				notify-send 'Android SDK' 'have already installed!✔'
				# file on /usr/lib/android-sdk
				;;

			8)
				#JDK 8
				echo "Installing JDK 8"
				mkdir /usr/lib/jvm
				wget -d -c -O /usr/lib/jvm/jdk-8u221-linux-x64.tar.gz https://www118.zippyshare.com/d/wDrNrELY/32132/jdk-8u221-linux-x64.tar.gz -
				tar zxvf /usr/lib/jvm/jdk-8u221-linux-x64.tar.gz
				mv jdk1.8.0_221 /usr/lib/jvm/
				rm -rf /usr/lib/jvm/jdk-8u221-linux-x64.tar.gz
				notify-send 'JDK 8' 'have already installed!✔'
				;;
			
			9)
				#Appium
				echo "Installing Appium"
				mkdir ./Documents/AppiumApps
				wget -d -c -O ~/Documents/AppiumApps/Appium-linux-1.15.1.AppImage https://www106.zippyshare.com/d/FXY8w9qY/4713/Appium-linux-1.15.1.AppImage -
				chmod +x ~/Documents/AppiumApps/Appium-linux-1.15.1.AppImage
				sudo ~/Documents/AppiumApps/Appium-linux-1.15.1.AppImage
				notify-send 'Appium' 'have already installed!✔'
				# create to stsrt
				;;

			10)
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
