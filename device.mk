#
# Copyright 2013 The Android Open-Source Project
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

# Need AppWidget permission to prevent from Launcher's crash.
# TODO(pattjin): Remove this when the TV Launcher is used, which does not support AppWidget.
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml

# Taken from device/google/atv/tv_core_hardware.xml and modified to include some tablet features
PRODUCT_COPY_FILES += \
    device/asus/fugu/fugu_core_hardware.xml:system/etc/permissions/fugu_core_hardware.xml \
    device/asus/fugu/android.hardware.type.television.xml:system/etc/permissions/android.hardware.type.television.xml


PRODUCT_AAPT_CONFIG := normal large xlarge hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# xhdpi, while we are hardcoding the 1080 resolution.
# when we start doing 720 as well, will need to stop hardcoding this.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=320

# There may be a cleaner way to do this.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heapgrowthlimit=128m \
    dalvik.vm.heapsize=174m

$(call inherit-product-if-exists, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

PRODUCT_CHARACTERISTICS := nosdcard,tv

DEVICE_PACKAGE_OVERLAYS := \
    device/asus/fugu/overlay

PRODUCT_COPY_FILES += \
    device/asus/fugu/fstab.fugu:root/fstab.fugu \
    device/asus/fugu/init.fugu.rc:root/init.fugu.rc \
    device/asus/fugu/init.fugu.usb.rc:root/init.fugu.usb.rc \
    device/asus/fugu/ueventd.fugu.rc:root/ueventd.fugu.rc \
    device/asus/fugu/init.recovery.fugu.rc:root/init.recovery.fugu.rc

# Audio
PRODUCT_PACKAGES += \
    libtinyalsa \
    audio.a2dp.default \
    audio.primary.fugu \
    audio.r_submix.default \
    audio.usb.default

USE_CUSTOM_AUDIO_POLICY := 1

# Camera
PRODUCT_PACKAGES += \
    camera.fugu \
    libs3cjpeg

PRODUCT_PROPERTY_OVERRIDES += \
    ro.camera.number=1 \
    ro.camera.0.devname=/dev/video0 \
    ro.camera.0.facing=back \
    ro.camera.0.orientation=0

# specific management of audio_policy.conf
PRODUCT_COPY_FILES += \
    device/asus/fugu/audio_policy.conf:system/etc/audio_policy.conf

# Hdmi CEC: Fugu works as a playback device (4).
PRODUCT_PROPERTY_OVERRIDES += ro.hdmi.device_type=4

# Add props used in stock
PRODUCT_PROPERTY_OVERRIDES +=  \
    ro.dalvik.vm.isa.arm=x86 \
    ro.enable.native.bridge.exec=1 \
    ro.vold.wipe_on_crypt_fail=1 \
    ro.nrdp.modelgroup=NEXUSPLAYERFUGU \
    drm.service.enabled=true \
    ro.com.widevine.cachesize=16777216 \
    media.stagefright.cache-params=10240/20480/15 \
    media.aac_51_output_enabled=true \
    dalvik.vm.implicit_checks=none

# Set the prop to enable arm native bridge
ADDITIONAL_DEFAULT_PROPERTIES += ro.dalvik.vm.native.bridge=libhoudini.so

# Enable frame-exact AV sync
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.media.avsync=true

# set USB OTG enabled to add support for USB storage type
PRODUCT_PROPERTY_OVERRIDES += persist.sys.isUsbOtgEnabled=1

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.sys.usb.config=mtp

# Include the Tv parts for use
PRODUCT_PACKAGES += \
    TvProvider \
    TvSettings \
    tv_input.default

# Include AppDrawer
#PRODUCT_PACKAGES += \
#    AppDrawer

# Bluetooth
PRODUCT_PACKAGES += \
    bt_bcm4354

PRODUCT_COPY_FILES += \
    device/asus/fugu/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
    device/asus/fugu/wifi/bcmdhd.cal:system/etc/wifi/bcmdhd.cal \
    device/asus/fugu/wifi/bcmdhd_sr2.cal:system/etc/wifi/bcmdhd_sr2.cal

# IMG graphics
PRODUCT_PACKAGES += \
    IMG_graphics \
    hwcomposer.moorefield

#Video
PRODUCT_COPY_FILES += \
    device/asus/fugu/media_profiles.xml:system/etc/media_profiles.xml \
    device/asus/fugu/wrs_omxil_components.list:system/etc/wrs_omxil_components.list \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    device/asus/fugu/media_codecs.xml:system/etc/media_codecs.xml \
    device/asus/fugu/vp9_interpredict.binary:system/etc/vp9_interpredict.binary \
    device/asus/fugu/mfx_omxil_core.conf:system/etc/mfx_omxil_core.conf \
    device/asus/fugu/video_isv_profile.xml:system/etc/video_isv_profile.xml


# psb video
PRODUCT_PACKAGES += \
    pvr_drv_video

# Media SDK and OMX IL components
PRODUCT_PACKAGES += \
    libmfxsw32 \
    libmfx_omx_core \
    libmfx_omx_components_sw \
    libgabi++-mfx \
    libstlport-mfx

#video firmware
PRODUCT_PACKAGES += \
    msvdx.bin.0008.0000.0000 \
    msvdx.bin.0008.0000.0001 \
    msvdx.bin.0008.0002.0001 \
    msvdx.bin.0008.0000.0002 \
    msvdx.bin.000c.0001.0001 \
    topaz.bin.0008.0000.0000 \
    topaz.bin.0008.0000.0001 \
    topaz.bin.0008.0000.0002 \
    topaz.bin.0008.0002.0001 \
    topaz.bin.000c.0001.0001 \
    vsp.bin.0008.0000.0000 \
    vsp.bin.0008.0000.0001 \
    vsp.bin.0008.0000.0002 \
    vsp.bin.0008.0002.0001 \
    vsp.bin.000c.0001.0001
# libva
PRODUCT_PACKAGES += \
    libva \
    libva-android \
    libva-tpi \
    vainfo

#libstagefrighthw
PRODUCT_PACKAGES += \
    libstagefrighthw

# libmix
PRODUCT_PACKAGES += \
    libmixvbp_mpeg4 \
    libmixvbp_h264 \
    libmixvbp_h264secure \
    libmixvbp_vc1 \
    libmixvbp_vp8 \
    libmixvbp \
    libva_videodecoder \
    libva_videoencoder

PRODUCT_PACKAGES += \
    libwrs_omxil_common \
    libwrs_omxil_core_pvwrapped \
    libOMXVideoDecoderAVC \
    libOMXVideoDecoderH263 \
    libOMXVideoDecoderMPEG4 \
    libOMXVideoDecoderWMV \
    libOMXVideoDecoderVP8 \
    libOMXVideoDecoderVP9HWR \
    libOMXVideoDecoderVP9Hybrid \
    libOMXVideoEncoderAVC \
    libOMXVideoEncoderH263 \
    libOMXVideoEncoderMPEG4 \
    libOMXVideoEncoderVP8

#libISV
PRODUCT_PACKAGES += libisv_omx_core

# pvr
PRODUCT_PACKAGES += \
    libpvr2d

# libdrm
PRODUCT_PACKAGES += \
    libdrm \
    dristat \
    drmstat

# Wifi
PRODUCT_PACKAGES += \
    libwpa_client \
    lib_driver_cmd_bcmdhd \
    hostapd \
    dhcpcd.conf \
    wpa_supplicant \
    bcmdhd.cal \
    bcmdhd_sr2.cal

# Recovery
PRODUCT_PACKAGES += librecovery_ui_fugu

PRODUCT_COPY_FILES += \
    device/asus/fugu/wpa_supplicant.conf:/system/etc/wifi/wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:system/etc/permissions/android.hardware.hdmi.cec.xml

# Key layout files
PRODUCT_COPY_FILES += \
    device/asus/fugu/keylayout/gpio-keys.idc:system/usr/idc/gpio-keys.idc \
    device/asus/fugu/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/asus/fugu/keylayout/gpio-keys.kcm:system/usr/keychars/gpio-keys.kcm \
    device/asus/fugu/keylayout/Spike.kl:system/usr/keylayout/Spike.kl \
    device/asus/fugu/keylayout/Nexus_Remote.kl:system/usr/keylayout/Nexus_Remote.kl \
    device/asus/fugu/keylayout/Vendor_2836_Product_0001.kl:system/usr/keylayout/Vendor_2836_Product_0001.kl

#GFX Config
PRODUCT_COPY_FILES += \
    device/asus/fugu/powervr.ini:system/etc/powervr.ini

# Thermal itux
ENABLE_ITUXD := true
PRODUCT_PACKAGES += \
    ituxd

# Power HAL
PRODUCT_PACKAGES += \
    power.fugu

# Debug rc files
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_COPY_FILES += \
    device/asus/fugu/init.fugu.diag.rc.userdebug:root/init.fugu.diag.rc
endif

$(call inherit-product-if-exists, vendor/asus/fugu/device-vendor.mk)
$(call inherit-product-if-exists, vendor/intel/PRIVATE/fugu/device-vendor.mk)
$(call inherit-product-if-exists, vendor/intel/moorefield/prebuilts/houdini/houdini.mk)

# Add WiFi Firmware
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4354/device-bcm.mk)

# specific management of sep_policy.conf
PRODUCT_COPY_FILES += \
    device/asus/fugu/sep_policy.conf:system/etc/security/sep_policy.conf

#PRODUCT_CHARACTERISTICS := tablet
