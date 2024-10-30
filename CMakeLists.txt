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

set(RV32_LINKER_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/default.ld)

include(cmake/device/vexiiriscv.cmake)

set(TARGET hello-world)

add_executable(${TARGET})

target_setup_rv32(${TARGET})

target_compile_features(
    ${TARGET}
    PRIVATE
        cxx_std_23
)

target_sources(
    ${TARGET}
    PRIVATE
        main.cpp
        start.S
        trap.S
)

target_link_options(
    ${TARGET}
    PRIVATE
        #--specs=nosys.specs
        #"LINKER:--gc-sections"
        #"LINKER:-flto"
)
