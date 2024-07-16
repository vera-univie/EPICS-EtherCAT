#!bin/linux-x86_64/veraBasic
dbLoadDatabase("dbd/veraBasic.dbd")
veraBasic_registerRecordDeviceDriver(pdbbase)

ecAsynInit("/tmp/scan1", 1000000)
 
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.0.0.255")
epicsEnvSet("EPICS_CAS_AUTO_BEACON_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CAS_BEACON_ADDR_LIST", "10.0.0.255")

dbLoadRecords("../../db/MASTER.template", "DEVICE=VERA:0,PORT=MASTER0,SCAN=I/O Intr")
dbLoadRecords("../../db/EK1100.template", "DEVICE=VERA:1,PORT=COUPLER_00,SCAN=I/O Intr")
dbLoadRecords("../../db/EL2808.template", "DEVICE=VERA:2,PORT=DO_00,SCAN=I/O Intr")
dbLoadRecords("../../db/EL2808.template", "DEVICE=VERA:3,PORT=DO_01,SCAN=I/O Intr")
dbLoadRecords("../../db/EL2808.template", "DEVICE=VERA:4,PORT=DO_02,SCAN=I/O Intr")
dbLoadRecords("../../db/EL2624.template", "DEVICE=VERA:5,PORT=RO_00,SCAN=I/O Intr")
dbLoadRecords("../../db/EL2652.template", "DEVICE=VERA:6,PORT=RO_01,SCAN=I/O Intr")
dbLoadRecords("../../db/EL4134.template", "DEVICE=VERA:7,PORT=AO_00,SCAN=I/O Intr")
dbLoadRecords("../../db/EL3104.template", "DEVICE=VERA:8,PORT=AI_00,SCAN=I/O Intr")
dbLoadRecords("../../db/EL3681.template", "DEVICE=VERA:9,PORT=MT_00,SCAN=I/O Intr")
dbLoadRecords("../../db/EL2258.template", "DEVICE=VERA:10,PORT=DO_03,SCAN=I/O Intr")
dbLoadRecords("db/CALCULATION.db", "")

iocInit()
