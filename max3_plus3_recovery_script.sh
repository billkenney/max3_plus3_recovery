#!/bin/bash
echo 'this script will update the firmware for a qidi max 3 or plus 3 to version 4.3.13'
echo 'if you choose to update your printer.cfg, it will save the current config to printer.cfg.bak'

read -p "what is your printer's ip address? " ip_address
read -p 'is your printer the (1) max 3 or (2) the plus 3? ' printer

if [[ "$printer" -eq 1 ]] ; then
  if [ -f *-plus3* ] ; then rm *-plus3* ; fi
  read -p 'does your printer have the (1) bltouch (which has orange on the side) or the (2) probe? ' probe
  if [[ "$probe" -eq 1 ]] ; then
    if [ -f printer-max3_probe.cfg ] ; then rm printer-max3_probe.cfg ; fi
  elif [[ "$probe" -eq 2 ]] ; then
    if [ -f printer-max3_bltouch.cfg ] ; then rm printer-max3_bltouch.cfg ; fi
  else
    echo "ERROR: invalid response"
    exit 0
  fi
  read -p 'do you want to update your printer.cfg file? (y/n) ' cfg
  echo "###############################################################################
please enter the password 'makerbase' if prompted (there should be two prompts)
###############################################################################"
  if [[ "$cfg" =~ [yY] ]] ; then
    echo "#!/bin/bash
if [ -f /home/mks/klipper_config/printer.cfg ] ; then
  mv /home/mks/klipper_config/printer.cfg /home/mks/klipper_config/printer.cfg.bak
fi
mv *.cfg /home/mks/klipper_config/printer.cfg
sudo dpkg -i mksclient-max3.deb
sudo mv 800_480.tft /root/" > recovery_script.sh
    scp recovery_script.sh *.cfg *.deb *.tft mks@"$ip_address":/home/mks
  elif [[ "$cfg" =~ [nN] ]] ; then
    if [ -f *.cfg ] ; then rm *.cfg ; fi
    echo "#!/bin/bash
sudo dpkg -i mksclient-max3.deb
sudo mv 800_480.tft /root/" > recovery_script.sh
    scp recovery_script.sh *.deb *.tft mks@"$ip_address":/home/mks
  else
    echo "ERROR: invalid response"
    exit 0
  fi
  ssh mks@"$ip_address" "cd /home/mks ; chmod +x recovery_script.sh ; /bin/bash recovery_script.sh"
elif [[ "$printer" -eq 2 ]] ; then
  if [ -f *-max3* ] ; then rm *-max3* ; fi
  read -p 'do you want to update your printer.cfg file? (y/n) ' cfg
  echo "###############################################################################
please enter the password 'makerbase' if prompted (there should be two prompts)
###############################################################################"
  if [[ "$cfg" =~ [yY] ]] ; then
    echo "#!/bin/bash
if [ -f /home/mks/klipper_config/printer.cfg ] ; then
  mv /home/mks/klipper_config/printer.cfg /home/mks/klipper_config/printer.cfg.bak
fi
mv *.cfg /home/mks/klipper_config/printer.cfg
sudo dpkg -i mksclient-plus3.deb
sudo mv 800_480.tft /root/" > recovery_script.sh
    scp recovery_script.sh *.cfg *.deb *.tft mks@"$ip_address":/home/mks
 elif [[ "$cfg" =~ [nN] ]] ; then
    if [ -f *.cfg ] ; then rm *.cfg ; fi
    echo "#!/bin/bash
sudo dpkg -i mksclient-plus3.deb
sudo mv 800_480.tft /root/" > recovery_script.sh
    scp recovery_script.sh *.deb *.tft mks@"$ip_address"
  else
    echo "ERROR: invalid response"
    exit 0
  fi
  ssh mks@"$ip_address" "cd /home/mks ; chmod +x recovery_script.sh ; /bin/bash recovery_script.sh"
else
  echo "ERROR: invalid response"
  exit 0
fi

echo 'the mksclient has been installed, and the mksrecovery file has been moved to your root directory'
echo 'please turn off your printer, wait for 20 seconds, and turn it back on'
echo 'the firmware update will take about 30 minutes, you can see the progress on your screen'
