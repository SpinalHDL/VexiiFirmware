set(TARGET system)

add_library(${TARGET} INTERFACE IMPORTED GLOBAL)

target_sources(
    ${TARGET}
    INTERFACE
        ${CMAKE_SOURCE_DIR}/device/common/start.S
        ${CMAKE_SOURCE_DIR}/device/common/trap.S
        ${CMAKE_SOURCE_DIR}/device/common/trap.cpp
        ${CMAKE_SOURCE_DIR}/device/common/trap.hpp

        peripherals.hpp
        soc.cpp
        soc.hpp
)
