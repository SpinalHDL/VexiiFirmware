#include <array>
#include <cstddef>
#include <cstdint>
#include <string>

#include "hal/uart.h"
#include "hal/uart/uart.hpp"
#include "utils/bytes.hpp"

extern "C"
void
trap()
{

}

#define UART_A 0x10001000

[[noreturn]]
int
main()
{
    hal::uart uart(UART_A);

    const auto str = "Hello Vexii!\n";

    while (true) {
        uart.write(utils::to_bytes(str));
    }
}
