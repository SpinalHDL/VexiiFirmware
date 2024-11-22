set(TARGET system)

add_library(${TARGET} INTERFACE IMPORTED GLOBAL)

target_sources(
    ${TARGET}
    INTERFACE
        start.S
        trap.S

        peripherals.hpp
        soc.cpp
        soc.hpp
        trap.cpp
        trap.hpp
)
