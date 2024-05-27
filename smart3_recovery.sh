#!/bin/bash
read -p 'do you want to update your printer.cfg file? (y/n): ' pcfg
if [[ "$pcfg" =~ [yY] ]] ; then
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/printer-smart3.cfg
  mv ~/klipper_config/printer.cfg ~/klipper_config/printer.cfg.bak
  mv printer-smart3.cfg ~/klipper_config/printer.cfg
  sudo sed -i 's/deb.debian.org\/debian buster-backports/archive.debian.org\/debian buster-backports/g' /etc/apt/sources.list
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/800_480-smart3.tft
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/mksclient-smart3.deb
  sudo dpkg -i mksclient-smart3.deb
  sudo mv 800_480-smart3.tft /root/800_480.tft
elif [[ "$pcfg" =~ [nN] ]] ; then
  sudo sed -i 's/deb.debian.org\/debian buster-backports/archive.debian.org\/debian buster-backports/g' /etc/apt/sources.list
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/800_480-smart3.tft
  wget --no-check-certificate https://raw.githubusercontent.com/billkenney/max3_plus3_recovery/main/mksclient-smart3.deb
  sudo dpkg -i mksclient-smart3.deb
  sudo mv 800_480-smart3.tft /root/800_480.tft
else
  echo "ERROR: invalid response"
  exit 0
fi

echo "the printer firmware updates have been installed. turn your printer off, wait for 15 seconds, and turn it back on. there should be a white screen with a progress indicator. once that's complete, reboot your printer again and you should be good to go"
