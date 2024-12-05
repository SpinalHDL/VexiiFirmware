cmake_minimum_required(VERSION 3.22)


if(NOT DEFINED DEVICE)
    message(FATAL_ERROR "DEVICE variable is not defined. Use -DDEVICE=<device_name> when running cmake.")
endif()

# Construct the path to the device-specific CMakeLists.txt
set(DEVICE_CMAKE_FILE "${CMAKE_SOURCE_DIR}/device/${DEVICE}")

# Verify that the specified CMakeLists.txt exists
if(EXISTS ${DEVICE_CMAKE_FILE})
    add_subdirectory(${DEVICE_CMAKE_FILE})
else()
    message(FATAL_ERROR "Device configuration file not found: ${DEVICE_CMAKE_FILE}")
endif()

include(cmake/toolchain/riscv.cmake)

project(
    vexii-firmware
    VERSION 0.0.0
    LANGUAGES
        ASM
        C
        CXX
)

add_subdirectory(common)
add_subdirectory(app)
