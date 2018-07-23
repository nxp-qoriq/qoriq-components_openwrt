#
# Copyright 2018 NXP
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Device/Default
  PROFILES := Default
  IMAGES := firmware.bin
  FILESYSTEMS := ubifs
  KERNEL := kernel-bin | gzip | uImage gzip
  KERNEL_LOADADDR := 0x80080000
  KERNEL_ENTRY_POINT := 0x80080000
endef

define Device/ls1012ardb
  DEVICE_TITLE := LS1012ARDB
  DEVICE_PACKAGES += \
    layerscape-rcw-ls1012ardb \
    layerscape-ppfe \
    layerscape-ppa-ls1012ardb \
    kmod-ppfe
  DEVICE_DTS := freescale/fsl-ls1012a-rdb
  UBIFS_OPTS := -m 1 -e 262016 -c 128
  UBINIZE_OPTS := -E 5
  BLOCKSIZE := 256KiB
  PAGESIZE := 1
  IMAGE/firmware.bin := \
    ls-clean | \
    ls-append $(1)-rcw.bin | pad-to 1M | \
    ls-append $(1)-uboot.bin | pad-to 3M | \
    ls-append $(1)-uboot-env.bin | pad-to 4M | \
    ls-append $(1)-ppa.itb | pad-to 10M | \
    ls-append pfe.itb | pad-to 15M | \
    ls-append-dtb $$(DEVICE_DTS) | pad-to 16M | \
    append-kernel | pad-to 32M | \
    append-ubi | check-size 67108865
endef
TARGET_DEVICES += ls1012ardb

define Device/ls1012afrwy
  DEVICE_TITLE := LS1012AFRWY
  DEVICE_PACKAGES += \
    layerscape-rcw-ls1012afrwy \
    layerscape-ppfe \
    layerscape-ppa-ls1012afrwy \
    kmod-ppfe
  DEVICE_DTS := freescale/fsl-ls1012a-frwy
  FILESYSTEMS := ext4
  IMAGES := firmware.bin sdcard.img
  IMAGE/firmware.bin := \
    ls-clean | \
    ls-append $(1)-rcw.bin | pad-to 128K | \
    ls-append pfe.itb | pad-to 384K | \
    ls-append $(1)-ppa.itb | pad-to 1024K | \
    ls-append $(1)-uboot.bin | pad-to 1856K | \
    ls-append $(1)-uboot-env.bin | pad-to 2048K | \
    check-size 2097153
  IMAGE/sdcard.img := \
    ls-clean | \
    ls-append-sdhead $(1) | pad-to 15M | \
    ls-append-dtb $$(DEVICE_DTS) | pad-to 16M | \
    append-kernel | pad-to $(LS_SD_ROOTFSPART_OFFSET)M | \
    append-rootfs | check-size $(LS_SD_IMAGE_SIZE)
endef
TARGET_DEVICES += ls1012afrwy

define Device/ls1043ardb
  DEVICE_TITLE := LS1043ARDB
  DEVICE_PACKAGES += \
    layerscape-rcw-ls1043ardb \
    layerscape-fman-ls1043ardb \
    layerscape-ppa-ls1043ardb \
    fmc fmc-eth-config
  DEVICE_DTS := freescale/fsl-ls1043a-rdb-sdk
  FILESYSTEMS := squashfs
  IMAGE/firmware.bin := \
    ls-clean | \
    ls-append $(1)-rcw.bin | pad-to 1M | \
    ls-append $(1)-uboot.bin | pad-to 3M | \
    ls-append $(1)-uboot-env.bin | pad-to 4M | \
    ls-append $(1)-ppa.itb | pad-to 9M | \
    ls-append $(1)-fman.bin | pad-to 15M | \
    ls-append-dtb $$(DEVICE_DTS) | pad-to 16M | \
    append-kernel | pad-to 32M | \
    append-rootfs | pad-rootfs | check-size 67108865
endef
TARGET_DEVICES += ls1043ardb

define Device/ls1043ardb-sdboot
  DEVICE_TITLE := LS1043ARDB (SD Card Boot)
  DEVICE_PACKAGES += \
    layerscape-fman-ls1043ardb \
    layerscape-ppa-ls1043ardb \
    fmc fmc-eth-config
  DEVICE_DTS := freescale/fsl-ls1043a-rdb-sdk
  FILESYSTEMS := ext4
  IMAGES := sdcard.img
  IMAGE/sdcard.img := \
    ls-clean | \
    ls-append-sdhead $(1) | pad-to 4K | \
    ls-append $(1)-uboot.bin | pad-to 3M | \
    ls-append $(1)-uboot-env.bin | pad-to 4M | \
    ls-append ls1043ardb-ppa.itb | pad-to 9M | \
    ls-append ls1043ardb-fman.bin | pad-to 15M | \
    ls-append-dtb $$(DEVICE_DTS) | pad-to 16M | \
    append-kernel | pad-to $(LS_SD_ROOTFSPART_OFFSET)M | \
    append-rootfs | check-size $(LS_SD_IMAGE_SIZE)
endef
TARGET_DEVICES += ls1043ardb-sdboot

define Device/ls1046ardb
  DEVICE_TITLE := LS1046ARDB
  DEVICE_PACKAGES += \
    layerscape-rcw-ls1046ardb \
    layerscape-fman-ls1046ardb \
    layerscape-ppa-ls1046ardb \
    fmc fmc-eth-config
  DEVICE_DTS := freescale/fsl-ls1046a-rdb-sdk
  UBIFS_OPTS := -m 1 -e 262016 -c 128
  UBINIZE_OPTS := -E 5
  BLOCKSIZE := 256KiB
  PAGESIZE := 1
  IMAGE/firmware.bin := \
    ls-clean | \
    ls-append $(1)-rcw.bin | pad-to 1M | \
    ls-append $(1)-uboot.bin | pad-to 3M | \
    ls-append $(1)-uboot-env.bin | pad-to 4M | \
    ls-append $(1)-ppa.itb | pad-to 9M | \
    ls-append $(1)-fman.bin | pad-to 15M | \
    ls-append-dtb $$(DEVICE_DTS) | pad-to 16M | \
    append-kernel | pad-to 32M | \
    append-ubi | check-size 67108865
endef
TARGET_DEVICES += ls1046ardb

define Device/ls1046ardb-sdboot
  DEVICE_TITLE := LS1046ARDB (SD Card Boot)
  DEVICE_PACKAGES += \
    layerscape-fman-ls1046ardb \
    layerscape-ppa-ls1046ardb \
    fmc fmc-eth-config
  DEVICE_DTS := freescale/fsl-ls1046a-rdb-sdk
  FILESYSTEMS := ext4
  IMAGES := sdcard.img
  IMAGE/sdcard.img := \
    ls-clean | \
    ls-append-sdhead $(1) | pad-to 4K | \
    ls-append $(1)-uboot.bin | pad-to 3M | \
    ls-append $(1)-uboot-env.bin | pad-to 4M | \
    ls-append ls1046ardb-ppa.itb | pad-to 9M | \
    ls-append ls1046ardb-fman.bin | pad-to 15M | \
    ls-append-dtb $$(DEVICE_DTS) | pad-to 16M | \
    append-kernel | pad-to $(LS_SD_ROOTFSPART_OFFSET)M | \
    append-rootfs | check-size $(LS_SD_IMAGE_SIZE)
endef
TARGET_DEVICES += ls1046ardb-sdboot

define Device/ls1088ardb
  DEVICE_TITLE := LS1088ARDB
  DEVICE_PACKAGES += \
    layerscape-rcw-ls1088ardb \
    layerscape-mc-ls1088ardb \
    layerscape-dpl-ls1088ardb \
    layerscape-ppa-ls1088ardb \
    restool
  DEVICE_DTS := freescale/fsl-ls1088a-rdb
  UBIFS_OPTS := -m 1 -e 262016 -c 128
  UBINIZE_OPTS := -E 5
  BLOCKSIZE := 256KiB
  PAGESIZE := 1
  IMAGE/firmware.bin := \
    ls-clean | \
    ls-append $(1)-rcw.bin | pad-to 1M | \
    ls-append $(1)-uboot.bin | pad-to 3M | \
    ls-append $(1)-uboot-env.bin | pad-to 4M | \
    ls-append $(1)-ppa.itb | pad-to 10M | \
    ls-append $(1)-mc.itb | pad-to 13M | \
    ls-append $(1)-dpl.dtb | pad-to 14M | \
    ls-append $(1)-dpc.dtb | pad-to 15M | \
    ls-append-dtb $$(DEVICE_DTS) | pad-to 16M | \
    append-kernel | pad-to 32M | \
    append-ubi | check-size 67108865
endef
TARGET_DEVICES += ls1088ardb

define Device/ls1088ardb-sdboot
  DEVICE_TITLE := LS1088ARDB (SD Card Boot)
  DEVICE_PACKAGES += \
    layerscape-rcw-ls1088ardb-sdboot \
    layerscape-mc-ls1088ardb \
    layerscape-dpl-ls1088ardb \
    layerscape-ppa-ls1088ardb \
    restool
  DEVICE_DTS := freescale/fsl-ls1088a-rdb
  FILESYSTEMS := ext4
  IMAGES := sdcard.img
  IMAGE/sdcard.img := \
    ls-clean | \
    ls-append-sdhead $(1) | pad-to 4K | \
    ls-append $(1)-rcw.bin | pad-to 1M | \
    ls-append $(1)-uboot.bin | pad-to 3M | \
    ls-append $(1)-uboot-env.bin | pad-to 4M | \
    ls-append ls1088ardb-ppa.itb | pad-to 10M | \
    ls-append ls1088ardb-mc.itb | pad-to 13M | \
    ls-append ls1088ardb-dpl.dtb | pad-to 14M | \
    ls-append ls1088ardb-dpc.dtb | pad-to 15M | \
    ls-append-dtb $$(DEVICE_DTS) | pad-to 16M | \
    append-kernel | pad-to $(LS_SD_ROOTFSPART_OFFSET)M | \
    append-rootfs | check-size $(LS_SD_IMAGE_SIZE)
endef
TARGET_DEVICES += ls1088ardb-sdboot

define Device/ls2088ardb
  DEVICE_TITLE := LS2088ARDB
  DEVICE_PACKAGES += \
    layerscape-rcw-ls2088ardb \
    layerscape-mc-ls2088ardb \
    layerscape-dpl-ls2088ardb \
    layerscape-ppa-ls2088ardb \
    restool
  DEVICE_DTS := freescale/fsl-ls2088a-rdb
  FILESYSTEMS := squashfs
  IMAGE/firmware.bin := \
    ls-clean | \
    ls-append $(1)-rcw.bin | pad-to 1M | \
    ls-append $(1)-uboot.bin | pad-to 3M | \
    ls-append $(1)-uboot-env.bin | pad-to 4M | \
    ls-append $(1)-ppa.itb | pad-to 10M | \
    ls-append $(1)-mc.itb | pad-to 13M | \
    ls-append $(1)-dpl.dtb | pad-to 14M | \
    ls-append $(1)-dpc.dtb | pad-to 15M | \
    ls-append-dtb $$(DEVICE_DTS) | pad-to 16M | \
    append-kernel | pad-to 32M | \
    append-rootfs | pad-rootfs | check-size 67108865
endef
TARGET_DEVICES += ls2088ardb
