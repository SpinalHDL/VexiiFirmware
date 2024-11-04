#include <array>
#include <cstddef>
#include <cstdint>
#include <string>

#include "hal/uart.h"

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
    int i = 0;

    while (true) {
        i++;
        uart_write(UART_A, 'u');

    }
}
