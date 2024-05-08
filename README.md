# max3_plus3_recovery
This is a manual install script for qidi max3/plus3 firmware 4.3.13 for people with the error message that "the system starts abnormally!", a blank screen, or you're unable to update the firmware for some reason. Simply download the files or clone the repository, make the script executable (chmod +x max3_plus3_recovery_script.sh), and run the script (./max3_plus3_recovery_script.sh). Based on your answers to the prompts, it will create a simple recovery script, copy the necessary files to your printer via scp, ssh into your printer, update your printer.cfg file (if you select this option), install the mksclient, and copy the mksrecovery file to your root folder. Afterwards, turn your printer off, wait for a bit, turn it back on, and the firmware update will take place. 

The 800_480.tft file is the same as the QD_Max3_UI5.0 and the QD_Plus3_UI5.0, and is the same for both printers. The mksclient-max3.deb is the same as the QD_Max_SOC file, and the mksclient-plus3.deb is the same as the QD_Plus_SOC file. The only change I made was to comment out the line "systemctl disable gpio-monitor.service" in the DEBIAN/postinst script, because that service did not exist on my printer and it caused the firmware update to fail. 

The script should work with any flavor of linux or mac. If the script doesn't work for you (or if you don't want to use it), you can manually install the recovery files yourself. Download the files specific to your printer, put them on a flash drive or copy them to your printer via scp, then ssh into your printer and manually install them. 

For instance, if your printer is the Max 3 with the BLTouch probe and you want to update your printer.cfg file, you would do the following (ssh/scp default password is makerbase, and it's also the default sudo/root password):
1. download 800_480.tft, mksclient-max3.deb, printer-max3_bltouch.cfg
2. "scp 800_480.tft mksclient-max3.deb printer-max3_bltouch.cfg mks@printer.ip.address:/home/mks" (or copy these files to a flash drive)
3. ssh into your printer: "ssh mks@printer.ip.address"
4. if you scp'd the files to your home directory: "mv /home/mks/klipper_config/printer.cfg /home/mks/klipper_config/printer.cfg.bak ; mv printer-max3_bltouch.cfg /home/mks/klipper_config/printer.cfg ; sudo dpkg -i mksclient-max3.deb ; sudo mv 800_480.tft /root/"
5. if you copied the files onto a flash drive: "mv /home/mks/klipper_config/printer.cfg /home/mks/klipper_config/printer.cfg.bak ; mv /home/mks/gcode_files/sda1/printer-max3_bltouch.cfg /home/mks/klipper_config/printer.cfg ; sudo dpkg -i /home/mks/gcode_files/sda1/mksclient-max3.deb ; sudo mv /home/mks/gcode_files/sda1/800_480.tft /root/"
6. turn your printer off, wait for a bit, turn it back on, and the firmware update will take place. 
