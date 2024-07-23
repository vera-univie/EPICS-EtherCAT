TOP = .
include $(TOP)/configure/CONFIG
DIRS := $(DIRS) $(filter-out $(DIRS), etc)
DIRS := $(DIRS) $(filter-out $(DIRS), configure)
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard Application))
DIRS := $(DIRS) $(filter-out $(DIRS), $(wildcard iocBoot))
include $(TOP)/configure/RULES_TOP