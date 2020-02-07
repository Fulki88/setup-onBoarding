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
	options=(1 "Build Essentials" on
	         2 "Node.js" on
			 3 "NPM" on
	         4 "Git" on
			#  5 "GitKraken" off
			 6 "Visual Studio Code" on
			 7 "Android SDK" on
	        #  8 "JDK 8" off
			#  9 "Appium" on
	         10 "Google Chrome" on
			 11 "Docker" on)
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
			# 5)
			# 	#Install gitKraken
			# 	echo "Installing GitKraken"
			# 	wget -d -c -O ~/Downloads/GitKraken-v5.0.4.deb https://www54.zippyshare.com/d/jncjkiA7/25650/GitKraken-v5.0.4.deb -
			# 	dpkg -i ~/Downloads/GitKraken-v5.0.4.deb
			# 	notify-send 'GitKraken' 'have already installed!✔'
			# 	;;
			6)
				#Install Visual Studio Code
				echo "Installing Visual Studio Code"
				snap install code --classic
				notify-send 'Visual Studio Code' 'have already installed!✔'
				;;
			7)
				#Android SDK
				echo "Installing Android SDK"
				apt install android-sdk -y
				notify-send 'Android SDK' 'have already installed!✔'
				# file on /usr/lib/android-sdk
				;;
			# 8)
			# 	#JDK 8
			# 	echo "Installing JDK 8"
			# 	mkdir /usr/lib/jvm
			# 	wget -d -c -O /usr/lib/jvm/jdk-8u221-linux-x64.tar.gz https://www118.zippyshare.com/d/wDrNrELY/32132/jdk-8u221-linux-x64.tar.gz -
			# 	tar zxvf /usr/lib/jvm/jdk-8u221-linux-x64.tar.gz
			# 	mv jdk1.8.0_221 /usr/lib/jvm/
			# 	rm -rf /usr/lib/jvm/jdk-8u221-linux-x64.tar.gz
			# 	notify-send 'JDK 8' 'have already installed!✔'
			# 	;;
		
			# 9)
			# 	#Appium
			# 	echo "Installing Appium"
			# 	mkdir ./Documents/AppiumApps
			# 	wget -d -c -O ~/Documents/AppiumApps/Appium-linux-1.15.1.AppImage https://www106.zippyshare.com/d/FXY8w9qY/4713/Appium-linux-1.15.1.AppImage -
			# 	chmod +x ~/Documents/AppiumApps/Appium-linux-1.15.1.AppImage
			# 	notify-send 'Appium' 'have already installed!✔'
			# 	# create to stsrt
			# 	;;
			10)
				#Chrome
				echo "Installing Google Chrome"
				wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
				sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
				apt-get update 
				apt-get install google-chrome-stable -y
				notify-send 'Google Chrome' 'have already installed!✔'
				;;
			11)
				#Docker
				echo "Installing Docker"
				# sudo apt-get remove docker docker-engine docker.io
				sudo apt install docker.io -y
				sudo systemctl start docker
				sudo systemctl enable docker
				notify-send 'Docker' 'have already installed!✔'
				;;
	    esac
	done
fi
