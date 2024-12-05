set(TARGET example-hello_world)

add_executable(${TARGET})

target_setup_cpp(${TARGET})

target_sources(
    ${TARGET}
    PRIVATE
        main.cpp
)
