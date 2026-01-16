# SPDX-License-Identifier: GPL-2.0
# Copyright (c) 2022 Intel Corporation.

KERNELRELEASE ?= $(shell uname -r)
KERNEL_SRC ?= /lib/modules/$(KERNELRELEASE)/build
KERNEL_VERSION := $(shell echo $(KERNELRELEASE) | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')
BUILD_EXCLUSIVE_KERNEL="^(6\.(1[278])\.)"

MODSRC := $(shell pwd)

subdir-ccflags-y += -DDRIVER_VERSION_SUFFIX=\"${DRIVER_VERSION_SUFFIX}\"

# Define config macros for conditional compilation in ipu6-acpi.c
# IS_ENABLED() checks for CONFIG_XXX or CONFIG_XXX_MODULE
subdir-ccflags-y += -DCONFIG_VIDEO_MAX9X_MODULE=1
subdir-ccflags-y += -DCONFIG_VIDEO_ISX031_MODULE=1

export EXTERNAL_BUILD = 1
export CONFIG_VIDEO_INTEL_IPU7 = m
export CONFIG_VIDEO_INTEL_IPU6 = m
export CONFIG_IPU_BRIDGE = n
export CONFIG_INTEL_IPU7_ACPI = m
export CONFIG_VIDEO_INTEL_IPU7_EXT_CTRLS = y

obj-y += drivers/media/pci/intel/ipu7/
obj-y += drivers/media/platform/intel/
subdir-ccflags-y += -I$(src)/include

export CONFIG_VIDEO_AR0234=m
export CONFIG_VIDEO_ISX031=m
export CONFIG_VIDEO_IMX390=m
export CONFIG_VIDEO_MAX9X=m
export CONFIG_VIDEO_D4XX_MAX9295 = m
export CONFIG_VIDEO_D4XX_MAX9296 = m
export CONFIG_VIDEO_D4XX_MAX96724 = m
export CONFIG_VIDEO_D4XX = m

obj-y += drivers/media/i2c/

export CONFIG_INTEL_IPU_ACPI = m
obj-y += drivers/media/platform/intel/

subdir-ccflags-y += -I$(src)/include/ \
	-DCONFIG_VIDEO_V4L2_SUBDEV_API
subdir-ccflags-$(CONFIG_IPU_BRIDGE) += \
	-DCONFIG_IPU_BRIDGE
subdir-ccflags-$(CONFIG_VIDEO_INTEL_IPU7) += \
	-DCONFIG_DEBUG_FS -DCONFIG_VIDEO_INTEL_IPU7_ISYS_RESET
subdir-ccflags-$(CONFIG_VIDEO_INTEL_IPU7_EXT_CTRLS) += \
        -DCONFIG_VIDEO_INTEL_IPU7_EXT_CTRLS
subdir-ccflags-$(CONFIG_INTEL_IPU_ACPI) += \
        -DCONFIG_INTEL_IPU_ACPI

subdir-ccflags-y += $(subdir-ccflags-m)

all:
	$(MAKE) -C $(KERNEL_SRC) M=$(MODSRC) modules
modules_install:
	$(MAKE) INSTALL_MOD_DIR=updates -C $(KERNEL_SRC) M=$(MODSRC) modules_install
clean:
	$(MAKE) -C $(KERNEL_SRC) M=$(MODSRC) clean
