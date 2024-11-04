add_subdirectory(clint)
add_subdirectory(plic)
add_subdirectory(uart)

add_subdirectory(legacy)

target_sources(
    ${TARGET}
    INTERFACE
        io.h
        type.h
)
