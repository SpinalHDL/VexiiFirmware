set(TARGET hal)

add_library(${TARGET} INTERFACE IMPORTED GLOBAL)

add_subdirectory(legacy)

add_subdirectory(riscv)
add_subdirectory(spinal)

target_include_directories(
    ${TARGET}
    INTERFACE
        ${CMAKE_CURRENT_LIST_DIR}/..
)
