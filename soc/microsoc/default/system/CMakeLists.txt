set(TARGET system)

add_library(${TARGET} INTERFACE IMPORTED GLOBAL)

target_sources(
    ${TARGET}
    INTERFACE
        ${CMAKE_SOURCE_DIR}/soc/common/start.S
        ${CMAKE_SOURCE_DIR}/soc/common/trap.S
        ${CMAKE_SOURCE_DIR}/soc/common/trap.cpp
        ${CMAKE_SOURCE_DIR}/soc/common/trap.hpp

        peripherals.hpp
        soc.cpp
        soc.hpp
)
