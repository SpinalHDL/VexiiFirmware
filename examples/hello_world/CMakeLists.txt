set(TARGET example-hello_world)

add_executable(${TARGET})

target_setup_example(${TARGET})

target_sources(
    ${TARGET}
    PRIVATE
        main.cpp
)
