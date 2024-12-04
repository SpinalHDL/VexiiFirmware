function(target_setup_rv32 TARGET)
    if (NOT RV32_LINKER_SCRIPT)
        set(RV32_LINKER_SCRIPT ${PROJECT_SOURCE_DIR}/device/${DEVICE}/linker/default.ld)
    endif()

    # Sanity checks
    if (NOT RV32_LINKER_SCRIPT)
        message(FATAL_ERROR "No RV32_LINKER_SCRIPT specified.")
    endif()
    if (NOT RV32_GENERATE_MAP)
        set(RV32_GENERATE_MAP ON)
    endif()
    if (NOT RV32_GENERATE_BIN)
        set(RV32_GENERATE_BIN OFF)
    endif()

    # ToDo: Handle this in a better way
    set(RV32_USE_FPU    OFF)
    set(RV32_DEVICE_CPU "rv32i")
    set(RV32_DEVICE_ABI "ilp32")

    # ToDo
    set(RV32_USE_FPU OFF)
    set(RV32_DEVICE_FLOAT_API "")

    set_target_properties(
        ${TARGET}
        PROPERTIES
            SUFFIX ".elf"
    )

    target_compile_options(
        ${TARGET}
        PRIVATE
            -march=rv32i
            -mabi=ilp32
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

            $<$<BOOL:${RV32_USE_FPU}>:-mfloat-abi=${RV32_DEVICE_FLOAT_ABI}>


            -I${PROJECT_SOURCE_DIR}/device/${DEVICE}
    )

    target_link_options(
        ${TARGET}
        PRIVATE
            -march=rv32i
            -mabi=ilp32
            -ffreestanding
            -nostartfiles
            $<$<BOOL:${RV32_USE_FPU}>:-mfloat-abi=${RV32_DEVICE_FLOAT_ABI}>

            $<$<BOOL:${RV32_GENERATE_MAP}>:LINKER:-Map=$<TARGET_FILE_DIR:${TARGET}>/$<TARGET_NAME_IF_EXISTS:${TARGET}>.map>
            -L${PROJECT_SOURCE_DIR}/device/${DEVICE}/linker
            -T ${RV32_LINKER_SCRIPT}
    )

    # Generate *.bin (if supposed to)
    if (RV32_GENERATE_BIN)
        set(RV32_BIN_PATH ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.bin)

        add_custom_command(
            TARGET ${TARGET}
            COMMENT "Generating *.bin"
            POST_BUILD
            BYPRODUCTS ${RV32_BIN_PATH}
            COMMAND ${BIN_OBJCOPY} -O binary $<TARGET_FILE:${TARGET}> ${RV32_BIN_PATH}
        )
    endif()

endfunction()
