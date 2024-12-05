set(TARGET asm-raw)

add_executable(${TARGET})

target_setup_asm(${TARGET})


target_sources(
    ${TARGET}
    PRIVATE
        start.S
)


