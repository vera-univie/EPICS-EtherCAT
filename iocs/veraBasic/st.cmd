#!bin/linux-x86_64/veraBasic
dbLoadDatabase("dbd/veraBasic.dbd")
veraBasic_registerRecordDeviceDriver(pdbbase)

ecAsynInit("/tmp/scan1", 1000000)
 
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.0.0.255")
epicsEnvSet("EPICS_CAS_AUTO_BEACON_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CAS_BEACON_ADDR_LIST", "10.0.0.255")

dbLoadRecords("../../db/MASTER.template", "DEVICE=LinuxI2:0,PORT=MASTER0,SCAN=I/O Intr")
dbLoadRecords("../../db/EK1100.template", "DEVICE=LinuxI2:1,PORT=COUPLER_00,SCAN=I/O Intr")
dbLoadRecords("../../db/EL2652.template", "DEVICE=LinuxI2:2,PORT=RO_00,SCAN=I/O Intr")

iocInit()
