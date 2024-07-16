This module is an adapted version of the ethercat module for EPICS made by Diamond Light Source (DLS).
It was made for use at VERA (University of Vienna), but should work on other systems, as long as it is properly installed.
See the installation guide, or use our installation scripts at ... to install


# ethercat
EPICS support to read/write to ethercat based hardware

Prerequisites: [IgH EtherCAT Master for Linux](http://etherlab.org/en/ethercat/index.php)

# Guide
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
To be safe, go into the Application folder of your IOC and make.

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
