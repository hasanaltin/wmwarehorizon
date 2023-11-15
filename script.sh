#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	echo "Updating and Upgrading"
	apt-get update && sudo apt-get upgrade -y

	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install: 4" )
	options=(1 "Sublime Text 3" off    # any option can be set to default to "on"
	         2 "ERY Support" off
	         3 "VMware Horizon Client" off
	         4 "SSH" off

		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
	        	1)
	            		#Install Sublime Text 3*
				echo "Installing Sublime Text"
				add-apt-repository ppa:webupd8team/sublime-text-3 -y
				apt update
				apt install sublime-text-installer -y
				;;

			2)
			    	#Install ERY Support
				echo "Downloading ERY Support Package"
				wget https://www.erybilisim.com/wp-content/vmwarehorizon/TeamViewerQS.tar.gz
	            
    			echo "Installing ERY Support"
	 			sudo tar -xvzf /home/ery/Downloads/TeamViewerQS.tar.gz

        		echo "Making Shortcut on Desktop"
				cp /home/ery/Downloads/TeamViewerQS/teamviewerqs/teamviewer.desktop ~/Desktop
				gio set ~/Desktop/teamviewer.desktop metadata::trusted true
				chmod a+x ~/Desktop/teamviewer.desktop
				;;
    		3)	
				#Install VMware Horizon Client
				echo "Downloading VMware Horizon Client"
				wget https://download3.vmware.com/software/CART24FQ3_LIN64_2309/VMware-Horizon-Client-2309-8.11.0-22660930.x64.bundle
				
				echo "Installing VMware Horizon Client"
				sh ./https://download3.vmware.com/software/CART24FQ3_LIN64_2309/VMware-Horizon-Client-2309-8.11.0-22660930.x64.bundle
				
				echo "Making Shortcut on Desktop"
				cp /usr/share/applications/vmware-view.desktop ~/Desktop
				gio set ~/Desktop/vmware-view.desktop metadata::trusted true
				chmod a+x ~/Desktop/vmware-view.desktop
				;;
				
			4)
				#Install SSH
				echo "Downloading SSH"
				apt get install ssh -y
				
				echo "Starting SSH Service"				
				systemctl start ssh
				systemctl enable ssh
				;;
	    esac
	done
fi
