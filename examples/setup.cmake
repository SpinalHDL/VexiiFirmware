include(${PROJECT_SOURCE_DIR}/cmake/device/vexiiriscv.cmake)

function(target_setup_example TARGET)

    target_setup_rv32(${TARGET})

    target_compile_features(
        ${TARGET}
            PRIVATE
            cxx_std_23
    )

    target_link_options(
        ${TARGET}
        PRIVATE
            #--specs=nosys.specs
            #"LINKER:--gc-sections"
            #"LINKER:-flto"
    )

    target_link_libraries(
        ${TARGET}
        PRIVATE
            hal
    )

    target_sources(
        ${TARGET}
        PRIVATE
            ${PROJECT_SOURCE_DIR}/common/startup/start.S
            ${PROJECT_SOURCE_DIR}/common/trap/trap.S
    )

endfunction()
