#pragma once

#include "peripherals.hpp"

#include <hal/clint/clint.hpp>
#include <hal/plic/plic.hpp>
#include <hal/uart/uart.hpp>

#include <chrono>

namespace soc
{

    static hal::clint clint(CLINT);
    static hal::plic plic(PLIC);
    static hal::uart uart(UART_A);

    /**
     * Initialize the SoC.
     */
    bool
    init();

    /**
     * Perform a blocking delay.
     */
    template<typename Rep, typename Period>
    void
    delay(const std::chrono::duration<Rep, Period> duration)
    {
        clint.delay(duration);
    }

}
