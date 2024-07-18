This module is an adapted version of the ethercat module for EPICS made by Diamond Light Source (DLS).
It was made for use at VERA (University of Vienna), but should work on other systems, as long as it is properly installed.
See the installation guide, or use [our installation scripts](https://github.com/vera-univie/Automated-Setup) to install


# ethercat
EPICS support to read/write to ethercat based hardware

Prerequisites: [IgH EtherCAT Master for Linux](http://etherlab.org/en/ethercat/index.php)

# Automated Installation and Setup (RECOMMENDED)
It is highly recommended that you use the setup scripts to easily and quickly setup EtherCAT for EPICS, as well as easily update your IOCs to work with new EtherCAT configurations.

You can find these at our [repository with all of the automation scripts to setup EtherCAT und EPICS](https://github.com/vera-univie/Automated-Setup)

# Manual Installation and Setup
## Installation and Setup
#########

When editing the different files, if one of these appears, change it to this value (replace the paths with your correct path):

VERSION= ## make this empty

ETHERLAB=/opt/etherlab/bin

ETHERLABPREFIX=$(ETHERLAB)/..

ETHERCAT=/home/user/EPICS/ethercat

ECASYN=/home/user/EPICS/ethercat

ASYN=/home/user/EPICS/support/asyn

SUPPORT=/home/user/EPICS/support

EPICS_BASE=/home/user/EPICS/epics-base

#########


Start in your base EPICS directory. This should also contain your epics-base, as well as your support folders.

Follow these steps (if '>' then enter into command line)

> git clone https://github.com/vera-univie/EPICS-EtherCAT.git ethercat
>
> cd ethercat

edit ethercatApp/scannerSrc/Makefile

Change lines as mentioned above ; below ETHERLABPREFIX, add:
> ETHERCAT_MASTER_ETHERLAB=/home/user/EtherLAB/ethercat-master-etherlab ## this must be the path to your EtherLAB Master

and modify these values:
> scanner_INCLUDES += -I$(ETHERCAT_MASTER_ETHERLAB)/lib
> 
> serialtool_INCLUDES += -I$(ETHERCAT_MASTER_ETHERLAB)/master
> 
> get-slave-revisions_INCLUDES += -I$(ETHERCAT_MASTER_ETHERLAB)/master

Now make the same modifications to ethercatApp/src/Makefile

Now edit all of these RELEASE files of the IOCs, by changing all of the appearing variables to the values that we have already defined at the beginning of the chapter
> iocs/scanTest/configure/RELEASE
> 
> iocs/veraBasic/configure/RELEASE
> 
> iocs/Backup_veraBasic/configure/RELEASE

## Configuration
### Example
To be safe, go into the Application folder of your IOC and > make.

Then execute following commands:

> cd ~/EPICS/ethercat/iocs/scanTest/etc
> 
> touch chain.xml

edit this file to add your components with their values (you can see these using the EtherCAT Master in your terminal), such as:
> \<chain>
> 
> \<device type_name="EK1100" revision="0x00110000" position="0" name="COUPLER_00" />
> 
> \<device type_name="EL2808" revision="0x00120000" position="1" name="DO_00" />
> 
> \<device type_name="EL2808" revision="0x00120000" position="2" name="DO_01" />
> 
> \<device type_name="EL2808" revision="0x00120000" position="3" name="DO_02" />
> 
> \</chain>

Check in ~/EPICS/ethercat/db if the template for your component is available. If not, do this:
> cd ~/EPICS/ethercat/etc/scripts
>
> python3 maketemplate.py -b ../xml/ -d EK1100 -r 0x00100000 -o ../../db/EK1100.template

In this command, -b is the folder with the information about all of the components, -d is the name of your component, -d is the revision number, and -o is the target destination. In this case you must replace -d with the correct component name, -r with the correct revision number, and write the correct component name for the .template file in -o

To see your revision number, go into root and call these commands:
> /etc/init.d/ethercat start
> 
> /opt/etherlab/bin/ethercat slaves -v

Now go back to the iocs/scanTest/etc folder, and call
> python3 ../../../etc/scripts/expandChain.py chain.xml > scanner.xml

Finally, go back to the top IOC folder, and edit the st.cmd file to include the dbLoadRecords() calls for your components.
> dbLoadRecords("../../db/MASTER.template", "DEVICE=VERA:0,PORT=MASTER0,SCAN=I/O Intr")
>
> dbLoadRecords("../../db/EK1100.template", "DEVICE=VERA:1,PORT=COUPLER_00,SCAN=I/O Intr")

You can freely change the values for DEVICE and for PORT - DEVICE is the name with which you will call the device, and PORT acts as a kind of extra name to identify it.

## Execution
Open a terminal, enter root (with 'su -'), and start your EtherCAT Master (as seen above)

Open another terminal, navigate to ~/EPICS/ethercat/iocs/scanTest/etc and start the scanner with the following command:
> sudo ../../../bin/linux-x86_64/scanner scanner.xml "/tmp/scan1"

Finally, open another terminal and navigate to the top folder of your ioc, e.g. ~/EPICS/ethercat/iocs/scanTest/ and execute following command:
> ./st.cmd

If at any point you can not run an executable due to missing permissions try one of these commands:
> sudo chmod u+x filename
>
> sudo chown user filename

Running ./st.cmd should now open the EPICS terminal. Use dbl to see all of you Process Variables (PVs), caput to write to a variable or caget to read from one.
