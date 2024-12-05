set(TARGET asm-app)

add_executable(${TARGET})

target_setup_cpp(${TARGET})

target_sources(
    ${TARGET}
    PRIVATE
        main.S
)


