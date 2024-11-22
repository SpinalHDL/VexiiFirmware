set(TARGET hal)

add_library(${TARGET} INTERFACE IMPORTED GLOBAL)

add_subdirectory(legacy)

add_subdirectory(clint)
add_subdirectory(gpio)
add_subdirectory(plic)
add_subdirectory(uart)

target_include_directories(
    ${TARGET}
    INTERFACE
        ${CMAKE_CURRENT_LIST_DIR}/..
)
