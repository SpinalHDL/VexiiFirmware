# Print useful stuff
message(STATUS "Using toolchain \"riscv\"")
message(STATUS "Using TOOLCHAIN_PATH: ${TOOLCHAIN_PATH}")

# CMake system / cross-compile information
set(CMAKE_SYSTEM_NAME               "Generic")
set(CMAKE_SYSTEM_PROCESSOR          "riscv32")
set(CMAKE_CROSSCOMPILING            ON)
set(CMAKE_TRY_COMPILE_TARGET_TYPE   STATIC_LIBRARY)

# Helper function to get locate (find) toolchain binaries
function(_find_tool VAR_NAME BINARY_NAME)
    if (NOT EXISTS CACHE{${VAR_NAME}})
        # Try to locate tool
        find_program(
            ${VAR_NAME}
            ${BINARY_NAME}
            PATHS
            ${TOOLCHAIN_PATH}
            DOC "${BINARY_NAME} path"
        )

        # Check whether we found the tool
        if(NOT ${VAR_NAME})
            message(FATAL_ERROR "Could not find toolchain binary \"${BINARY_NAME}\". Try setting TOOLCHAIN_PATH to point to the path containing the binaries.")
        endif()
    endif()
endfunction()

# Find tools
set(PREFIX "riscv64-unknown-elf")
_find_tool(BIN_COMPILER_C       ${PREFIX}-gcc)
_find_tool(BIN_COMPILER_CXX     ${PREFIX}-g++)
_find_tool(BIN_COMPILER_ASM     ${PREFIX}-gcc)
_find_tool(BIN_AR               ${PREFIX}-ar)
_find_tool(BIN_OBJCOPY          ${PREFIX}-objcopy)
_find_tool(BIN_OBJDUMP          ${PREFIX}-objdump)
_find_tool(BIN_SIZE             ${PREFIX}-size)

# Set tools
set(CMAKE_C_COMPILER    ${BIN_COMPILER_C})
set(CMAKE_CXX_COMPILER  ${BIN_COMPILER_CXX})
set(CMAKE_ASM_COMPILER  ${BIN_COMPILER_ASM})
set(CMAKE_AR            ${BIN_AR})
set(CMAKE_OBJCOPY       ${BIN_OBJCOPY})
set(CMAKE_OBJDUMP       ${BIN_OBJDUMP})

# Print memory usage
add_link_options(-Wl,--print-memory-usage)
