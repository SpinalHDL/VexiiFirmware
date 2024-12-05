cmake_minimum_required(VERSION 3.22)


if(NOT DEFINED SOC)
    message(FATAL_ERROR "SOC variable is not defined. Use -DSOC=<soc_name> when running cmake.")
endif()

# Construct the path to the device-specific CMakeLists.txt
set(SOC_CMAKE_FILE "${CMAKE_SOURCE_DIR}/soc/${SOC}/CMakeLists.txt")

# Verify that the specified CMakeLists.txt exists
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
