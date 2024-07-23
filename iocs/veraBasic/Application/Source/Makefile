TOP = ../..
include $(TOP)/configure/CONFIG
PROD_IOC = veraBasic
DBD                    += veraBasic.dbd
veraBasic_DBD          += base.dbd
veraBasic_DBD          += ecAsyn.dbd
veraBasic_SRCS         += veraBasic_registerRecordDeviceDriver.cpp
veraBasic_SRCS_DEFAULT += Application.cpp
veraBasic_SRCS_vxWorks += -nil-
veraBasic_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary
veraBasic_LIBS         += ecAsyn
veraBasic_LIBS         += asyn
veraBasic_LIBS         += $(EPICS_BASE_IOC_LIBS)
include $(TOP)/configure/RULES