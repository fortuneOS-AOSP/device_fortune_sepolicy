#
# This policy configuration will be used by all products that
# inherit from TheParasiteProject
#

ifeq ($(TARGET_COPY_OUT_VENDOR), vendor)
ifeq ($(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE),)
TARGET_USES_PREBUILT_VENDOR_SEPOLICY ?= true
endif
endif

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    device/fortune/sepolicy/common/public

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/fortune/sepolicy/common/private

ifeq ($(TARGET_BUILD_VARIANT),user)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/fortune/sepolicy/common/private/recovery \
    device/fortune/sepolicy/common/private/backuptool
endif

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/fortune/sepolicy/common/dynamic \
    device/fortune/sepolicy/common/system

else
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/fortune/sepolicy/common/dynamic \
    device/fortune/sepolicy/common/vendor
endif

# Pixel common
TARGET_INCLUDE_PIXEL_SEPOLICY ?= true
ifeq ($(TARGET_INCLUDE_PIXEL_SEPOLICY), true)
BOARD_SEPOLICY_DIRS += \
    device/fortune/sepolicy/common/private/google

ifeq ($(TARGET_USES_PREBUILT_VENDOR_SEPOLICY), true)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    device/fortune/sepolicy/common/system/google
else
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/fortune/sepolicy/common/vendor/google
endif

# Flipendo
BOARD_SEPOLICY_DIRS += \
    hardware/google/pixel-sepolicy/flipendo

# google_battery service
BOARD_SEPOLICY_DIRS += \
    hardware/google/pixel-sepolicy/googlebattery

# turbo_adapter
BOARD_SEPOLICY_DIRS += \
    hardware/google/pixel-sepolicy/turbo_adapter/private

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += \
    hardware/google/pixel-sepolicy/turbo_adapter/public
endif

# Qcom/MTK
ifeq ($(BOARD_USES_QCOM_HARDWARE), true)
-include device/fortune/sepolicy/qcom/sepolicy.mk
else ifeq ($(BOARD_HAS_MTK_HARDWARE), true)
-include device/fortune/sepolicy/mediatek/sepolicy.mk
endif

ifneq ($(BOARD_USES_QCOM_HARDWARE), true)
# Microsoft
BOARD_SEPOLICY_DIRS += \
    device/fortune/sepolicy/common/private/microsoft
endif
