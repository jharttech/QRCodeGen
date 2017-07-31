#!/bin/bash
#########################################################

# This script will combine the creation of a custom URL QR
# Code with the ability to input the dimensions desired.

#########################################################

# Global Variables

_GT='\033[0;32m'
_NC='\033[0m'

#########################################################
# Logo call

cat jhart_shell_logo.txt

########################################################

echo "  "
echo "Going to check on needed tools. If they are not found they will be installed."
_PKG_OK=$(dpkg-query -W --showformat='${Status}\n' imagemagick|grep "install ok installed")
echo Checking for imagemagick: $_PKG_OK
if [ "" == "$_PKG_OK" ]; then
  echo "No imagemagick install found. Setting up imagemagick now."
  sudo apt-get --force-yes --yes install imagemagick
fi

_PKG_OKTwo=$(dpkg-query -W --showformat='${Status}\n' qrencode|grep "install ok installed")
echo Checking for qrencode: $_PKG_OKTwo
if [ "" == "$_PKG_OKTwo" ]; then
  echo "No qrencode install found. Setting up qrencode."
  sudo apt-get --force-yes --yes install qrencode
fi


#clear
#echo "Now going to install needed tools"
#sudo apt-get update
#sudo apt-get install imagemagick qrencod -y
cd ~/Pictures
echo "##################################################################"
echo -e "$_GT Please enter the name of the QRCode and press enter key. $_NC"
read _QRName
echo -e "$_GT Please enter the URL or Web Address you want your QR Code to link to and press enter key. $_NC"
read _QRLink
qrencode -o "$_QRName"resize.png "$_QRLink"
echo -e "$_GT Please enter your desired QR Code pixel width and press enter. The Height will automatically be matched to the width to keep aspect ratio. $_NC"
read _Width
convert  "$_QRName"resize.png -scale "$_Width"x"$_Width" -quality 100 "$_QRName".png
rm "$_QRName"resize.png
echo "#################################################################"
echo "Your new QR Code image will now be displayed.  You can also find it in your ~/Pictures folder.  Now ending script."
display -geometry 100%+0+0 "$_QRName".png &
exit

