#
# Copyright (C) 2017 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

include vendor/twrp/soong/makevars.mk

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55

ENABLE_CPUSETS := true
TARGET_CPU_SMP := true
TARGET_IS_64_BIT := true
TARGET_BOOTLOADER_BOARD_NAME := t1016
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Platform
TARGET_BOARD_PLATFORM := mt6853

BOARD_KERNEL_CMDLINE += bootopt=64S3,32N2,64N2
# androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x40078000
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_SECOND_OFFSET := 0xbff88000
BOARD_TAGS_OFFSET := 0x0bc08000
BOARD_DTB_OFFSET := 0x0bc08000
BOARD_KERNEL_PAGESIZE := 2048
TARGET_PREBUILT_KERNEL := device/alldocube/t1016/prebuilt/Image.gz-dtb
#BOARD_INCLUDE_RECOVERY_DTBO := true
#BOARD_PREBUILT_DTBOIMAGE := device/alldocube/t1016/prebuilt/dtbo.img
BOARD_HEADER_VERSION := 2
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset 0x07c08000 --second_offset 0xbff88000 --dtb_offset 0x0bc08000 --tags_offset 0x0bc08000 --header_version $(BOARD_HEADER_VERSION) --dtb device/alldocube/t1016/prebuilt/dtbo.img
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb


# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 41943040
TARGET_USERIMAGES_USE_F2FS := true
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
boot \
system \
product \
vendor

TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true

BOARD_AVB_VBMETA_SYSTEM := system product
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_PARTITION_LIST := system product
BOARD_MAIN_SIZE := 3221225472

# Metadata
BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS += metadata

TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4

BOARD_AVB_ENABLE := true

# TWRP
TW_THEME := portrait_hdpi
BOARD_SUPPRESS_SECURE_ERASE := true
TW_DEFAULT_BRIGHTNESS := "80"
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libpuresoftkeymasterdevice \
    ashmemd_aidl_interface-cpp \
    libashmemd_client

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/ashmemd_aidl_interface-cpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libashmemd_client.so

AB_OTA_UPDATER := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_RECOVERY_ADDITIONAL_RELINK_BINARY_FILES += out/target/product/$(PRODUCT_HARDWARE)/system/bin/strace
TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += out/target/product/$(PRODUCT_HARDWARE)/system/lib64/android.hardware.oemlock@1.0.so

PLATFORM_SECURITY_PATCH := 2025-12-31
PLATFORM_VERSION := 20.1.0
VENDOR_SECURITY_PATCH := 2025-12-31
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
# MTP will not work until we update it to support ffs
TW_EXCLUDE_MTP := true
TW_USE_TOOLBOX := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TW_NO_HAPTICS := true
TW_INCLUDE_REPACKTOOLS := true
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := zh_CN
