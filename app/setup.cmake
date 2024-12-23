include(${PROJECT_SOURCE_DIR}/cmake/device/vexiiriscv.cmake)

function(target_setup_cpp TARGET)

    target_setup_riscv(${TARGET})

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
            system
            device
    )

endfunction()

function(target_setup_asm TARGET)

    target_setup_riscv(${TARGET})

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
    )

endfunction()
