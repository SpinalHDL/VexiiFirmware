set(TARGET example-uart)

add_executable(${TARGET})

target_setup_default(${TARGET})


target_sources(
    ${TARGET}
    PRIVATE
        main.cpp
)


