cmake_minimum_required(VERSION 3.30)

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
