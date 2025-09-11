# SPDX-License-Identifier: GPL-2.0
# Copyright (c) 2024 Intel Corporation.

is_kernel_lt_6_10 = $(shell if [ $$(printf "6.10\n$(KERNELVERSION)" | sort -V | head -n1) != "6.10" ]; then echo 1; fi)
ifeq ($(is_kernel_lt_6_10), 1)
ifneq ($(EXTERNAL_BUILD), 1)
src := $(srctree)/$(src)
endif
endif

ccflags-y += -I$(srcpath)/$(src)/../../../include/
ccflags-y += -I$(srcpath)/$(src)/../../../drivers/media/pci/intel/ipu7

ifeq ($(CONFIG_VIDEO_INTEL_IPU7), m)
	ccflags-y += -DCONFIG_VIDEO_INTEL_IPU7=1
endif
obj-$(CONFIG_VIDEO_OV02C10) += ov02c10.o
obj-$(CONFIG_VIDEO_ISX031) += isx031.o
obj-$(CONFIG_VIDEO_MAX9X) += max9x/
