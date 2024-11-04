#include <array>
#include <cstddef>
#include <cstdint>
#include <string>

#include "hal/clint/clint.hpp"
#include "hal/uart/uart.hpp"
#include "utils/bytes.hpp"

extern "C"
void
trap()
{

}

#define UART_A 0x10001000
#define CLINT  0x10010000

[[noreturn]]
int
main()
{
    using namespace std::chrono_literals;

    hal::uart uart(UART_A);
    hal::clint clint(CLINT);

    clint.setup(100'000'000);

    while (true) {
        uart.write(utils::to_bytes("Hello Vexii!\n"));
        clint.delay(3s);
    }
}
