#include <hal/clint/clint.hpp>
#include <hal/plic/plic.hpp>
#include <hal/uart/uart.hpp>
#include <utils/bytes.hpp>

#define UART_A 0x10001000
#define CLINT  0x10010000

extern "C"
void
trap()
{

}

[[noreturn]]
int
main()
{
    using namespace std::chrono_literals;

    hal::uart uart(UART_A);
    hal::clint clint(CLINT);

    clint.setup(100'000'000);

    uart.write(utils::to_bytes("Hello Vexii!\n"));

    while (true) {
        clint.delay(10ms);
    }
}
