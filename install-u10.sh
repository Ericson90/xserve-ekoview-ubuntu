#!/bin/bash
##

RootCheck()
{
	if [[ $EUID -ne 0 ]]; then
	   echo "This script must be run as root" 
	   exit 1
	fi
}

Welcome()
{
	echo "*************************************************************************";
	echo "EkoView Netbook Setup for Ubuntu (v1.15.7.6)";
	echo "Welcome $CurrentUser"
	echo "*************************************************************************";
}

Requirement()
{
	echo "*** This setup written for machines with the following specifications ***"
	echo "        OS  : Ubuntu 10.4 LTS (Lucid) only"
	echo "        CPU : Intel Atom 1.6 GHz and above"
	echo "        RAM : 512 MB and above"
	echo "        HDD : 3.5 GB (Minimum)"
	echo "              >5.0 GB (Recommended)"
	echo "FAILING to comply to above specification may cause certain component "
	echo "MALFUNCTIONS !!!"
	echo "*** This script will install required components and dependencies to"
	echo "    run XServe and EkoView on Linux OS Ubuntu 10.04 LTS (Lucid) ***"
	echo "*** Recommended to run this script for initial setup on fresh OS ***"
	echo ""
}

SourceList()
{
	echo "Updating source list...";
	rm /etc/apt/sources.list
	echo "#deb cdrom:[Ubuntu 10.04.4 LTS _Lucid Lynx_ - Release i386 (20120214.2)]/ lucid$
	# See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
	# newer versions of the distribution.

	deb http://us.archive.ubuntu.com/ubuntu/ lucid main restricted
	deb-src http://us.archive.ubuntu.com/ubuntu/ lucid main restricted

	## Major bug fix updates produced after the final release of the
	## distribution.
	deb http://us.archive.ubuntu.com/ubuntu/ lucid-updates main restricted
	deb-src http://us.archive.ubuntu.com/ubuntu/ lucid-updates main restricted

	## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
	## team. Also, please note that software in universe WILL NOT receive any
	## review or updates from the Ubuntu security team.
	deb http://us.archive.ubuntu.com/ubuntu/ lucid universe
	deb-src http://us.archive.ubuntu.com/ubuntu/ lucid universe
	deb http://us.archive.ubuntu.com/ubuntu/ lucid-updates universe
	deb-src http://us.archive.ubuntu.com/ubuntu/ lucid-updates universe

	## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu 
	## team, and may not be under a free licence. Please satisfy yourself as to 
	## your rights to use the software. Also, please note that software in 
	## multiverse WILL NOT receive any review or updates from the Ubuntu
	## security team.
	deb http://us.archive.ubuntu.com/ubuntu/ lucid multiverse
	deb-src http://us.archive.ubuntu.com/ubuntu/ lucid multiverse
	deb http://us.archive.ubuntu.com/ubuntu/ lucid-updates multiverse
	deb-src http://us.archive.ubuntu.com/ubuntu/ lucid-updates multiverse

	## Uncomment the following two lines to add software from the 'backports'
	## repository.
	## N.B. software from this repository may not have been tested as
	## extensively as that contained in the main release, although it includes
	## newer versions of some applications which may provide useful features.
	## Also, please note that software in backports WILL NOT receive any review
	## or updates from the Ubuntu security team.
	# deb http://us.archive.ubuntu.com/ubuntu/ lucid-backports main restricted univ$
	# deb-src http://us.archive.ubuntu.com/ubuntu/ lucid-backports main restricted $

	## Uncomment the following two lines to add software from Canonical's
	## 'partner' repository.
	## This software is not part of Ubuntu, but is offered by Canonical and the
	## respective vendors as a service to Ubuntu users.
	deb http://archive.canonical.com/ubuntu lucid partner
	deb-src http://archive.canonical.com/ubuntu lucid partner

	deb http://security.ubuntu.com/ubuntu lucid-security main restricted
	deb-src http://security.ubuntu.com/ubuntu lucid-security main restricted
	deb http://security.ubuntu.com/ubuntu lucid-security universe
	deb-src http://security.ubuntu.com/ubuntu lucid-security universe
	deb http://security.ubuntu.com/ubuntu lucid-security multiverse
	deb-src http://security.ubuntu.com/ubuntu lucid-security multiverse" > /etc/apt/sources.list
	echo "-->Sources list modified...";
	apt-get update
	echo "Updated successfully !";
	echo "";
}

ServerComponent()
{
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' apache2|grep "install ok installed")
	echo "Checking for apache2: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No apache2. Setting up apache2..."
	  sudo apt-get -fyV install apache2
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' apache2-doc|grep "install ok installed")
	echo "Checking for apache2-doc: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No apache2-doc. Setting up apache2-doc..."
	  sudo apt-get -fyV install apache2-doc
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' apache2-utils|grep "install ok installed")
	echo "Checking for apache2-utils: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No apache2-utils. Setting up apache2-utils..."
	  sudo apt-get -fyV install apache2-utils
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' php5|grep "install ok installed")
	echo "Checking for php5: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No php5. Setting up php5..."
	  sudo apt-get -fyV install php5
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' php-pear|grep "install ok installed")
	echo "Checking for php-pear: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No php-pear. Setting up php-pear..."
	  sudo apt-get -fyV install php-pear
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' php5-xcache|grep "install ok installed")
	echo "Checking for php5-xcache: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No php5-xcache. Setting up php5-xcache..."
	  sudo apt-get -fyV install php5-xcache
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' php5-suhosin|grep "install ok installed")
	echo "Checking for php5-suhosin: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No php5-suhosin. Setting up php5-suhosin..."
	  sudo apt-get -fyV install php5-suhosin
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' php5-mysql|grep "install ok installed")
	echo "Checking for php5-mysql: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No php5-mysql. Setting up php5-mysql..."
	  sudo apt-get -fyV install php5-mysql
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' libapache2-mod-ruby|grep "install ok installed")
	echo "Checking for libapache2-mod-ruby: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No libapache2-mod-ruby. Setting up libapache2-mod-ruby..."
	  sudo apt-get -fyV install libapache2-mod-ruby
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' libapache2-mod-perl2|grep "install ok installed")
	echo "Checking for libapache2-mod-perl2: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No libapache2-mod-perl2. Setting up libapache2-mod-perl2..."
	  sudo apt-get -fyV install libapache2-mod-perl2
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' libapache2-mod-python|grep "install ok installed")
	echo "Checking for libapache2-mod-python: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No libapache2-mod-python. Setting up libapache2-mod-python..."
	  sudo apt-get -fyV install libapache2-mod-python
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' python-mysqldb|grep "install ok installed")
	echo "Checking for python-mysqldb: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No python-mysqldb. Setting up python-mysqldb..."
	  sudo apt-get -fyV install python-mysqldb
	fi
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' libapache2-mod-php5|grep "install ok installed")
	echo "Checking for libapache2-mod-php5: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No libapache2-mod-php5. Setting up libapache2-mod-php5..."
	  sudo apt-get -fyV install libapache2-mod-php5
	fi
	echo "Installation complete !";
	echo "";
}

DownloadEkoView()
{
	echo "Backing up database..";
	mv -v /usr/xbow/www/sys/xserve_sqlite.db "/home/$CurrentUser/Desktop/xserve_sqlite_$(date '+%Y%m%d%H%M').db"
	rm -rf /usr/xbow
	mkdir /usr/xbow
	mkdir /usr/xbow/tmp
	if [ -f "EkoView-2.4.32.tar.gz" ]; then
		echo "Installer available !";
		cp EkoView-2.4.32.tar.gz /usr/xbow/tmp
	else
		wget https://unisense.ceastech.com/download/EkoView-2.4.32.tar.gz -P /usr/xbow/tmp
		echo "EkoView download successful !";
	fi
	echo "";
}

InstallEkoView()
{
	echo "Extracting files...";
	tar zxf /usr/xbow/tmp/EkoView-2.4.32.tar.gz -C /usr/xbow
	echo "Linking files...";
	ln -sv /usr/xbow/xserve-2.4.32 /usr/xbow/xserve
	ln -sv /usr/xbow/xserve/logs /usr/xbow/www/logs
	ln -sv /usr/xbow/xserve/web /usr/xbow/www/web
	ln -sv /usr/xbow/www/sys /usr/xbow/xserve-2.4.32/sys
	ln -sv /usr/xbow/cgi-bin /usr/xbow/xserve-2.4.32/web/cgi-bin
	ln -sv /usr/xbow/www/data /usr/xbow/xserve-2.4.32/web/data
	ln -sv /usr/xbow/www/images /usr/xbow/xserve-2.4.32/web/images
	echo "Removing temp...";
	rm -rf /usr/xbow/tmp
	echo "EkoView Installed !";
	echo "";
}

ConfigureApache()
{
	service apache2 stop
	echo "Apache service stopped gracefully !";
	echo "";
	echo "Configuring server...";
	cp -v /usr/xbow/xserve-2.4.32/apache2/apache2.conf /etc/apache2
	echo "Configuring ports...";
	cp -v /usr/xbow/xserve-2.4.32/apache2/ports.conf /etc/apache2
	echo "Configuring mods...";
	cp -v /usr/xbow/xserve-2.4.32/apache2/deflate.conf /etc/apache2/mods-available
	echo "Configuring sites...";
	cp -v /usr/xbow/xserve-2.4.32/apache2/default /etc/apache2/sites-available
	echo "Configuring environment...";
	rm /etc/apache2/envvars
	echo "# envvars - default environment variables for apache2ctl

	# Since there is no sane way to get the parsed apache2 config in scripts, some
	# settings are defined via environment variables and then used in apache2ctl,
	# /etc/init.d/apache2, /etc/logrotate.d/apache2, etc.
	export APACHE_RUN_USER=$CurrentUser
	export APACHE_RUN_GROUP=$CurrentUser
	export APACHE_PID_FILE=/var/run/apache2.pid

	## The locale used by some modules like mod_dav
	export LANG=C
	## Uncomment the following line to use the system default locale instead:
	## /etc/default/locale

	export LANG" > /etc/apache2/envvars
	chown -R $CurrentUser:$CurrentUser /var/lock/apache2
	service apache2 start
	echo "Apache server configuration done !";
	echo "";
}

Permission()
{
	echo "Changing permissions...";
	chown -R $CurrentUser:$CurrentUser /usr/xbow
	chmod -R 755 /usr/xbow
	chmod 555 /usr/xbow/ChangeLog.txt
	chmod 444 /usr/xbow/GatewayName.txt
	chmod 644 /usr/xbow/apache/htpasswd
	chmod 644 /usr/xbow/www/DisableGatewayBackup.txt
	chmod 644 /usr/xbow/www/DisableGatewayDiagnostics.txt
	chmod 700 /usr/xbow/www/sys
	chmod 664 /usr/xbow/www/sys/basejoinmap.xtbl
	chmod 664 /usr/xbow/www/sys/joinmap.xtbl
	chmod 644 /usr/xbow/www/sys/xserve_sqlite.db
	chmod 644 /usr/xbow/xserve-2.4.32/ChangeLog.txt
	chmod 644 /usr/xbow/xserve-2.4.32/mathopd.properties
	chmod 644 /usr/xbow/xserve-2.4.32/Version.txt
	chmod 644 /usr/xbow/xserve-2.4.32/xparams.args
	chmod 644 /usr/xbow/xserve-2.4.32/xparams.properties
	chmod 644 /usr/xbow/xserve-2.4.32/apache2/*
	chmod 711 /usr/xbow/xserve-2.4.32/bin/*
	chmod 755 /usr/xbow/xserve-2.4.32/bin/sqlite3
	chmod 700 /usr/xbow/xserve-2.4.32/configxml/eko
	chmod 700 /usr/xbow/xserve-2.4.32/configxml/kits
	chmod 700 /usr/xbow/xserve-2.4.32/configxml/sys
	chmod 700 /usr/xbow/xserve-2.4.32/configxml/test
	chmod 711 /usr/xbow/xserve-2.4.32/lib/commands/*
	chmod 711 /usr/xbow/xserve-2.4.32/lib/datasinks/*
	chmod 711 /usr/xbow/xserve-2.4.32/lib/parsers/*
	chmod 664 /usr/xbow/xserve-2.4.32/logs/*
	chmod -R 700 /usr/xbow/xserve-2.4.32/scripts/*
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/alert_sendmail.py
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/log2sim.pl
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/database/checkdb.pl
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/database/initdb.pl
	chmod -R 755 /usr/xbow/xserve-2.4.32/scripts/netbook/auto
	chmod -R 755 /usr/xbow/xserve-2.4.32/scripts/netbook/perl
	chmod 644 /usr/xbow/xserve-2.4.32/scripts/netbook/gatewayBackup.pl
	chmod 644 /usr/xbow/xserve-2.4.32/scripts/netbook/gatewayDiagnosticUpdate.py
	chmod 644 /usr/xbow/xserve-2.4.32/scripts/netbook/gatewayUpdate.py
	chmod 644 /usr/xbow/xserve-2.4.32/scripts/netbook/managedb
	chmod 644 /usr/xbow/xserve-2.4.32/scripts/netbook/manageusr
	chmod 644 /usr/xbow/xserve-2.4.32/scripts/netbook/serverwatch
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/netbook/xserve
	chmod 700 /usr/xbow/xserve-2.4.32/scripts/netbook/xservewatch
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/nslu2/gatewayBackup.pl
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/nslu2/gatewayDiagnosticUpdate.py
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/nslu2/gatewayUpdate.py
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/nslu2/managedb
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/nslu2/manageusr
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/nslu2/serverwatch
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/nslu2/xserve
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/nslu2/xservewatch
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/upgrade/upgrade.pl
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/upgrade/*/*
	chmod 755 /usr/xbow/xserve-2.4.32/scripts/vmware/*
	echo "Permissions Granted !";
	echo "";
}

CronTab()
{
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' gnome-schedule|grep "install ok installed")
	echo "Checking for gnome-schedule: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No gnome-schedule. Setting up gnome-schedule..."
	  sudo apt-get -fyV install gnome-schedule
	fi
	echo "30 * * * * /usr/xbow/xserve/scripts/netbook/serverwatch
@reboot /usr/xbow/xserve/scripts/netbook/serverwatch
* * * * * /usr/xbow/xserve/scripts/netbook/xservewatch
*/30 * * * * /usr/xbow/xserve/scripts/netbook/xservewatchhour
*/5 * * * * php5 -f /usr/xbow/www/web/sync/Sync.php" > mycron
	crontab mycron
	rm mycron
	echo "Cron job list...";
	crontab -l
	echo "XServe scheduling done !";
	echo "";
}

AdditionalPackages()
{
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' sqlite|grep "install ok installed")
	echo "Checking for sqlite: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No sqlite. Setting up sqlite..."
	  sudo apt-get -fyV install sqlite
	fi 
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' php5-sqlite|grep "install ok installed")
	echo "Checking for php5-sqlite: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No php5-sqlite. Setting up php5-sqlite..."
	  sudo apt-get -fyV install php5-sqlite
	fi 
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' sqlitebrowser|grep "install ok installed")
	echo "Checking for sqlitebrowser: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No sqlitebrowser. Setting up sqlitebrowser..."
	  sudo apt-get -fyV install sqlitebrowser
	fi 
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' curl|grep "install ok installed")
	echo "Checking for curl: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No curl. Setting up curl..."
	  sudo apt-get -fyV install curl
	fi 
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' libcurl3|grep "install ok installed")
	echo "Checking for libcurl3: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No libcurl3. Setting up libcurl3..."
	  sudo apt-get -fyV install libcurl3
	fi 
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' libcurl4-openssl-dev|grep "install ok installed")
	echo "Checking for libcurl4-openssl-dev: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No libcurl4-openssl-dev. Setting up libcurl4-openssl-dev..."
	  sudo apt-get -fyV install libcurl4-openssl-dev
	fi 
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' php5-curl|grep "install ok installed")
	echo "Checking for php5-curl: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No php5-curl. Setting up php5-curl..."
	  sudo apt-get -fyV install php5-curl
	fi 
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' htop|grep "install ok installed")
	echo "Checking for htop: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No htop. Setting up htop..."
	  sudo apt-get -fyV install htop
	fi
}

Footer()
{
	echo ""; echo "";
	echo "*********************************************************************";
	echo "+++ Hope you like this EkoView installer ****************************";
	echo "+++ Contact Ericson (Developer) if found bugs in this application ***";
	echo "+++ Center of Excellence for Advaned Sensor Technology (CEASTech) ***";
	echo "+++ Universiti Malaysia Perlis (UniMAP) *****************************";
	echo "*********************************************************************";
}

#######################
### Start Installer ###
#######################
RootCheck
CurrentUser=$(who am i | awk '{print $1}')
Welcome
Requirement
echo "   This installer will remove previous database, files & folders !!!";
read -p "      Do you want to continue ?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]] 
then
echo "";
echo "*************************************************************************";
echo "";
echo "......................................";
echo "...Updating Ubuntu 10.4 LTS (Lucid)...";
echo "......................................";
SourceList
echo "......................................";
echo "...Installing server and components...";
echo "......................................";
ServerComponent
echo "...................................";
echo "...Downloading EkoView installer...";
echo "...................................";
DownloadEkoView
echo "........................";
echo "...Installing EkoView...";
echo "........................";
InstallEkoView
echo "........................";
echo "...Configuring Apache...";
echo "........................";
ConfigureApache
echo ".................................";
echo "...Setting EkoView permissions...";
echo ".................................";
Permission
echo "..........................";
echo "...Setting up scheduler...";
echo "..........................";
CronTab
echo "......................................................";
echo "...Setting up FireFox web browser and flash support...";
echo "......................................................";
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' adobe-flashplugin|grep "install ok installed")
	echo "Checking for adobe-flashplugin: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	  echo "No adobe-flashplugin. Setting up adobe-flashplugin..."
	  apturl apt:adobe-flashplugin?channel=$distropartner
	fi
#echo 'user_pref("browser.search.defaulturl", "http://localhost/web/index.html");' >> ~/.mozilla/firefox/*.default/prefs.js;
echo "Firefox web browser setup done !";
echo "";
echo "...........................";
echo "...Installing TeamViewer...";
echo "...........................";
echo "Getting TeamViewer ready for remote access..."
	PKG_OK=$(dpkg-query -W --showformat='${Status}\n' teamviewer|grep "install ok installed")
	echo "Checking for teamviewer: $PKG_OK"
	if [ "" == "$PKG_OK" ]; then
	    echo "No teamviewer. Setting up teamviewer..."
		if [ -f teamviewer_i386.deb ]; then
			echo "TeamViewer available !"
			echo "Proceed to install Teamviever..."
			dpkg -i teamviewer_i386.deb
		else
			echo "Downloading TeamViewer..."
			wget http://download.teamviewer.com/download/teamviewer_i386.deb teamviewer_i386.deb
			echo "Proceed to install Teamviever..."
			dpkg -i teamviewer_i386.deb
		fi
	fi

echo "";
echo "....................................";
echo "...Installing additional packages...";
echo "....................................";
AdditionalPackages 

else [[ ! $REPLY =~ ^[Yy]$ ]]
echo "";
echo "Installation was cancelled by user !"; 
fi 

Footer
#######################
###  End Installer  ###
#######################
