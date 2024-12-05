function(target_setup_riscv TARGET)
    if (NOT RV_LINKER_SCRIPT)
        set(RV_LINKER_SCRIPT ${PROJECT_SOURCE_DIR}/device/${DEVICE}/linker/default.ld)
    endif()

    # Sanity checks
    if (NOT RV_GENERATE_MAP)
        set(RV_GENERATE_MAP ON)
    endif()
    if (NOT RV_GENERATE_BIN)
        set(RV_GENERATE_BIN OFF)
    endif()

    # ToDo: Handle this in a better way
    set(RV_USE_FPU    OFF)
    set(RV_ARCH "rv32i")
    set(RV_ABI "ilp32")

    # ToDo
    set(RV_USE_FPU OFF)
    set(RV_DEVICE_FLOAT_API "")

    set_target_properties(
        ${TARGET}
        PROPERTIES
            SUFFIX ".elf"
    )

    target_compile_options(
        ${TARGET}
        PRIVATE
            -march=${RV_ARCH}
            -mabi=${RV_ABI}
            #-g -ggdb
            #-mno-div
            -ffunction-sections
            -fdata-sections

            -Wall
            -Wextra
            -pedantic

            $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
            $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
            $<$<COMPILE_LANGUAGE:CXX>:-fno-use-cxa-atexit>

            $<$<BOOL:${RV_USE_FPU}>:-mfloat-abi=${RV_DEVICE_FLOAT_ABI}>


            -I${PROJECT_SOURCE_DIR}/device/${DEVICE}
    )

    target_link_options(
        ${TARGET}
        PRIVATE
            -march=rv32i
            -mabi=ilp32
            -ffreestanding
            -nostartfiles
            $<$<BOOL:${RV_USE_FPU}>:-mfloat-abi=${RV_DEVICE_FLOAT_ABI}>

            $<$<BOOL:${RV_GENERATE_MAP}>:LINKER:-Map=$<TARGET_FILE_DIR:${TARGET}>/$<TARGET_NAME_IF_EXISTS:${TARGET}>.map>
            -L${PROJECT_SOURCE_DIR}/device/${DEVICE}/linker
            -L${PROJECT_SOURCE_DIR}
            -T ${RV_LINKER_SCRIPT}
    )

    # Generate *.bin (if supposed to)
    if (RV_GENERATE_BIN)
        set(RV_BIN_PATH ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.bin)

        add_custom_command(
            TARGET ${TARGET}
            COMMENT "Generating *.bin"
            POST_BUILD
            BYPRODUCTS ${RV_BIN_PATH}
            COMMAND ${BIN_OBJCOPY} -O binary $<TARGET_FILE:${TARGET}> ${RV_BIN_PATH}
        )
    endif()

endfunction()
