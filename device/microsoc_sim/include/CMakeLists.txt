set(TARGET device)

add_library(${TARGET} INTERFACE IMPORTED GLOBAL)

target_sources(
    ${TARGET}
    INTERFACE
        device.hpp
)
