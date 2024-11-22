set(RV32_LINKER_SCRIPT ${PROJECT_SOURCE_DIR}/common/ld/default.ld)

set(TARGET hello-world)

add_executable(${TARGET})

target_setup_example(${TARGET})

target_sources(
    ${TARGET}
    PRIVATE
        main.cpp
)
