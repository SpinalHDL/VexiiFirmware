cmake_minimum_required(VERSION 3.22)


if(NOT DEFINED DEVICE)
    message(FATAL_ERROR "DEVICE variable is not defined. Use -DDEVICE=<device_name> when running cmake.")
endif()
set(DEVICE_CMAKE_FILE "${CMAKE_SOURCE_DIR}/device/${DEVICE}/CMakeLists.txt")
if(EXISTS ${DEVICE_CMAKE_FILE})
    include(${DEVICE_CMAKE_FILE})
else()
    message(FATAL_ERROR "Device configuration file not found: ${DEVICE_CMAKE_FILE}")
endif()


if(NOT DEFINED SOC)
    message(FATAL_ERROR "SOC variable is not defined. Use -DSOC=<soc_name> when running cmake.")
endif()
set(SOC_CMAKE_FILE "${CMAKE_SOURCE_DIR}/soc/${SOC}/CMakeLists.txt")
if(EXISTS ${SOC_CMAKE_FILE})
    include(${SOC_CMAKE_FILE})
else()
    message(FATAL_ERROR "SoC configuration file not found: ${SOC_CMAKE_FILE}")
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
