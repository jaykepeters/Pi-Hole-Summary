#!/bin/sh
## piholesummary
NAMEOFAPP="piholesummary"
WHATITDOES="This will send you daily emails of your pihole stats."


{ if 
(whiptail --title "$NAMEOFAPP" --yes-button "Skip" --no-button "Proceed" --yesno "Do you want to setup $NAMEOFAPP? $WHATITDOES" 10 80) 
then
else
## Sources and update
sudo echo 'deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi' | sudo tee --append /etc/apt/sources.list.d/stretch.list
sudo apt-get update -y
## Initial install and download
sudo apt-get install -t stretch -y npm
sudo npm install emailjs --save
sudo npm install simple-git --save
sudo npm install http --save
sudo npm install fs --save
sudo mkdir /etc/piholesummary
cd /etc/piholesummary
sudo wget https://raw.githubusercontent.com/deathbybandaid/Pi-Hole-Summary/master/index.js
sudo wget https://raw.githubusercontent.com/deathbybandaid/Pi-Hole-Summary/master/bare-config.json
sudo mv /etc/piholesummary/bare-config.json /etc/piholesummary/config.json
## Questions
PIHOLESENDEMAIL=$(whiptail --inputbox "What Email are you sending from?" 20 60 "PiHoleBot@host.com" 3>&1 1>&2 2>&3)
PIHOLESENDPASS=$(whiptail --inputbox "What is the password for $PIHOLESENDEMAIL" 20 60 "" 3>&1 1>&2 2>&3)
PIHOLEEMAILHOSTNAME=$(whiptail --inputbox "What is the email hostname?" 20 60 "smtp.host.net" 3>&1 1>&2 2>&3)
PIHOLEEMAILTONAME=$(whiptail --inputbox "What is the name of the recipient?" 20 60 "John Doe" 3>&1 1>&2 2>&3)
PIHOLEEMAILTOADDRESS=$(whiptail --inputbox "What email address should the emails go to?" 20 60 "somebody@gmail.net" 3>&1 1>&2 2>&3)
PIHOLEEMAILSSL=$(whiptail --inputbox "SSL true or false (lowercase)?" 20 60 "true" 3>&1 1>&2 2>&3)
## Setting up config
sudo sed -i "s/PiHoleBot@host.com/$PIHOLESENDEMAIL/" /etc/piholesummary/config.json
sudo sed -i "s/EmailPassword/$PIHOLESENDPASS/" /etc/piholesummary/config.json
sudo sed -i "s/smpt.host.com/$PIHOLEEMAILHOSTNAME/" /etc/piholesummary/config.json
sudo sed -i "s/John Doe/$PIHOLEEMAILTONAME/" /etc/piholesummary/config.json
sudo sed -i "s/miles@aaathats3as.com/$PIHOLEEMAILTOADDRESS/" /etc/piholesummary/config.json
sudo sed -i "s/true/$PIHOLEEMAILSSL/" /etc/piholesummary/config.json
## Setting up cronjob
(crontab -l ; echo "## Pihole Email") | crontab -
(crontab -l ; echo "59 23 * * * sudo nodejs /etc/piholesummary/index.js") | crontab -
(crontab -l ; echo "") | crontab -
## End of install
fi }
