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
			 5 "Visual Studio Code" on
			 6 "Android SDK" on
			 7 "Google Chrome" on
			 8 "Docker" on
			 9 "GitKraken" on
			10 "JDK 8" on
			11 "Appium" on
			12 "VPN" on
			13 "Virtual Box" on
			)
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
				#Install Visual Studio Code
				echo "Installing Visual Studio Code"
				snap install code --classic
				notify-send 'Visual Studio Code' 'have already installed!✔'
				;;
			6)
				#Android SDK
				echo "Installing Android SDK"
				apt install android-sdk -y
				# file on /usr/lib/android-sdk
				cat <<- 'eof' >> ~/.bashrc
					
					export ANDROID_HOME="/usr/lib/android-sdk"
					export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
					export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin
					export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/build-tools
				eof
				notify-send 'Android SDK' 'have already installed!✔'
				;;
			7)
				#Chrome
				echo "Installing Google Chrome"
				wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
				sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
				apt-get update 
				apt-get install google-chrome-stable -y
				notify-send 'Google Chrome' 'have already installed!✔'
				;;
			8)
				#Docker
				echo "Installing Docker"
				# echo "$SUDO_USER"
				touch ~/browsers.json
				cat << EOF > ~/browsers.json
{
  "firefox": {
    "default": "70.0",
    "versions": {
      "70.0": {
        "image": "selenoid/vnc_firefox:70.0",
        "port": "4444",
        "tmpfs": {
          "/tmp": "size=1024m"
        },
        "volumes": [
          "/home/${SUDO_USER}/images:/images"
        ]
      }
    }
  },
  "chrome": {
    "default": "78.0",
    "versions": {
      "78.0": {
        "image": "selenoid/vnc_chrome:78.0",
        "port": "4444",
        "tmpfs": {
          "/tmp": "size=1024m"
        },
        "volumes": [
          "/home/${SUDO_USER}/images:/images"
        ]
      }
    }
  }
}
EOF
				mkdir ~/images
				wget -d -c -O ~/docker-compose.yml https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/configDocker/docker-compose.yml
				chmod a+rwx ~/docker-compose.yml
				chmod a+rwx ~/browsers.json
				chmod a+rwx ~/images
				sudo apt-get update
				sudo apt-get install \
    				apt-transport-https \
    				ca-certificates \
    				curl \
    				gnupg-agent \
    				software-properties-common
				curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
				sudo apt-get update
				sudo apt-get install docker-ce docker-ce-cli containerd.io
				sudo groupadd docker
				sudo usermod -aG docker $SUDO_USER
				echo ""
				echo "write exit"
				echo ""
				newgrp docker 
				sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
				sudo chmod +x /usr/local/bin/docker-compose
				# pull images
				docker pull selenoid/vnc_chrome:78.0
				notify-send 'Docker' 'have already installed!✔'
				;;
			9)
				#Install gitKraken
				echo "Installing GitKraken"
				wget -d -c -O ~/Downloads/GitKraken-v5.0.4.ls.aa https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/GitKraken-v5.0.4.ls.aa
				wget -d -c -O ~/Downloads/GitKraken-v5.0.4.ls.ab https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/GitKraken-v5.0.4.ls.ab
				wget -d -c -O ~/Downloads/GitKraken-v5.0.4.ls.ac https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/GitKraken-v5.0.4.ls.ac				
				cat ~/Downloads/GitKraken-v5.0.4.ls.?? > ~/Downloads/GitKraken-v5.0.4.deb
				dpkg -i ~/Downloads/GitKraken-v5.0.4.deb
				rm -rf ~/Downloads/GitKraken-v5.0.4.ls.aa
				rm -rf ~/Downloads/GitKraken-v5.0.4.ls.ab
				rm -rf ~/Downloads/GitKraken-v5.0.4.ls.ac
				sudo apt-get install -f -y
				notify-send 'GitKraken' 'have already installed!✔'
				;;
			10)
				#JDK 8
				echo "Installing JDK 8"
				wget -d -c -O ~/Downloads/jdk.ls.aa https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/jdk.ls.aa
				wget -d -c -O ~/Downloads/jdk.ls.ab https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/jdk.ls.ab
				wget -d -c -O ~/Downloads/jdk.ls.ac https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/jdk.ls.ac
				wget -d -c -O ~/Downloads/jdk.ls.ad https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/jdk.ls.ad
				wget -d -c -O ~/Downloads/jdk.ls.ae https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/jdk.ls.ae
				wget -d -c -O ~/Downloads/jdk.ls.af https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/jdk.ls.af
				wget -d -c -O ~/Downloads/jdk.ls.ag https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/jdk.ls.ag
				wget -d -c -O ~/Downloads/jdk.ls.ah https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/jdk.ls.ah
				wget -d -c -O ~/Downloads/jdk.ls.ai https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/jdk.ls.ai
				cat ~/Downloads/jdk.ls.?? > ~/Downloads/jdk-8u221-linux-x64.tar.gz
				mkdir /usr/lib/jvm	
				sudo tar zxvf ~/Downloads/jdk-8u221-linux-x64.tar.gz
				sudo mv jdk1.8.0_221 /usr/lib/jvm/
				rm -rf ~/Downloads/jdk-8u221-linux-x64.tar.gz
				rm -rf ~/Downloads/jdk.ls.aa
				rm -rf ~/Downloads/jdk.ls.ab
				rm -rf ~/Downloads/jdk.ls.ac
				rm -rf ~/Downloads/jdk.ls.ad
				rm -rf ~/Downloads/jdk.ls.ae
				rm -rf ~/Downloads/jdk.ls.af
				rm -rf ~/Downloads/jdk.ls.ag
				rm -rf ~/Downloads/jdk.ls.ah
				rm -rf ~/Downloads/jdk.ls.ai
				cat <<- 'eof' >> ~/.bashrc
					
					export JAVA_HOME="/usr/lib/jvm/jdk1.8.0_221"
					export PATH=$PATH:$JAVA_HOME/bin
				eof
				notify-send 'JDK 8' 'have already installed!✔'
				;;
			11)
				#Appium
				echo "Installing Appium"
				mkdir ./Documents/AppiumApps
				wget -d -c -O ~/Downloads/appium.ls.aa https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/appium.ls.aa
				wget -d -c -O ~/Downloads/appium.ls.ab https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/appium.ls.ab
				wget -d -c -O ~/Downloads/appium.ls.ac https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/appium.ls.ac
				wget -d -c -O ~/Downloads/appium.ls.ad https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/appium.ls.ad
				wget -d -c -O ~/Downloads/appium.ls.ae https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/appium.ls.ae
				wget -d -c -O ~/Downloads/appium.ls.af https://raw.githubusercontent.com/Fulki88/setup-onBoardingQAAI/master/apps/appium.ls.af
				cat ~/Downloads/appium.ls.?? > ~/Documents/AppiumApps/Appium-linux-1.15.1.AppImage
				chmod a+rwx ~/Documents/AppiumApps/Appium-linux-1.15.1.AppImage
				rm -rf ~/Downloads/appium.ls.aa
				rm -rf ~/Downloads/appium.ls.ab
				rm -rf ~/Downloads/appium.ls.ac
				rm -rf ~/Downloads/appium.ls.ad
				rm -rf ~/Downloads/appium.ls.ae
				rm -rf ~/Downloads/appium.ls.af
				sudo apt-get install -f -y
				notify-send 'Appium' 'have already installed!✔'
				;;
			12)
				#VPN
				echo "Installing VPN"
				sudo apt install network-manager-l2tp
				sudo apt-get update
				sudo apt install network-manager-l2tp-gnome
				sudo service network-manager restart
				notify-send 'VPN' 'have already installed!✔'
				;;
			13)
				#Virtual Box
				echo "Installing Virtual Box"
				sudo add-apt-repository multiverse
				apt-get update
				apt install virtualbox
				;;
	    esac
	done

	#Autoremove
	echo ""
	echo "Autoremove Actived"
	apt autoremove -y
	echo "Autoremove Done"
fi
