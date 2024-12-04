cmake_minimum_required(VERSION 3.22)

set(DEVICE "default_value" CACHE STRING "Description of the variable")

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
add_subdirectory(examples)
