# WSN XServe and eKoview 2.x installer
## for Ubuntu 10.04 LTS or Ubuntu 12.04 LTS

### INTRODUCTION
The script will try mimic the actual xServe and eKoView system implementation that comes with Memsic Netbook.<br>
Please open the bash file in text editor and through the code before executing...<br>
You must be with root privilege to execute the code since many new packages will be installed.<br>
sudo bash install-u10.sh

### REQUIREMENT
- Memsic Base
- Memsic WSN Nodes
- Ubuntu 10.04 LTS or Ubuntu 12.04 LTS

### HOW TO INSTALL (sudo or root permission needed)
1. Run the installer with command 'sudo bash install.sh'. <br>

### HOW IT WORKS
The script will try mimic the actual xServe and eKoView system implementation that comes with Memsic Netbook.<br>
#### For Ubuntu 10.04,
- You must be root
- The source.list file will replaced to read from archive links since the support for Ubuntu 10.04 long terminated.
- Then updating the list for latest packages
- Next, long list of dependency packages will be installed automatically to install xServe
- xServe installer will be downloaded from my server
- Files extracted and folder permissions will be updated for xServe
- Next, the dependencies to install and run Apache HTTP Server to setup ekoView.
- The cron job to run xServe will be added as well, you can view at ' sudo crontab -l '
- Flash for Firefox will be installed too. However, the flash installer often fails, you can find the flash installer online.
- The ekoView should be accessible from FireFox browser at ' 127.0.0.1 '
- TeamViever will be installed as well for easy access from PC, you may skip this if not required.
#### For Ubuntu 12.04,
- You must be root
- Then updating the list for latest packages
- Next, long list of dependency packages will be installed automatically to install xServe
- xServe installer will be downloaded from my server
- Files extracted and folder permissions will be updated for xServe
- Next, the dependencies to install and run Apache HTTP Server to setup ekoView.
- The cron job to run xServe will be added as well, you can view at ' sudo crontab -l '
- Flash for Firefox will be installed too. However, the flash installer often fails, you can find the flash installer online.
- The ekoView should be accessible from FireFox browser at ' 127.0.0.1 '
- TeamViever will be installed as well for easy access from PC, you may skip this if not required.

### VERIFY INSTALLATION
1. Check xServe crontab
 -  xServe added to crontab automatically to check every minute for xServe running.
 -  Run this command to see if it's added, ' sudo crontab -l '
#### You should see this xServe entries...
30 * * * * /usr/xbow/xserve/scripts/netbook/serverwatch<br>
@reboot /usr/xbow/xserve/scripts/netbook/serverwatch<br>
* * * * * /usr/xbow/xserve/scripts/netbook/xservewatch<br>
0 * * * * /usr/xbow/xserve/scripts/netbook/xservewatchhour # JOB_ID_1<br>
2. Check eKoView website
 -  Apache HTTP Server will be installed and configured to run eKoView.
 -  eKoView can be accessed from internet browser at ' http://localhost/web/index.html '
 -  You can add nodes from the eKoView interface. **User : _admin_ Pass : _memsic_**
![alt text](https://unisense.ceastech.com/download/Interface.png "PC")

### REAL IMPLEMENTATION
#### Website - UniSense : IoT for Environmental Sensing
**_https://unisense.ceastech.com/_**
![alt text](https://unisense.ceastech.com/download/FullMap.png "Web")

Contact Developer,<br>
Ericson : _ericsonkanagaraj@gmail.com_
