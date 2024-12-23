#pragma once

#include "peripherals.hpp"

#include <hal/riscv/clint/clint.hpp>
#include <hal/riscv/plic/plic.hpp>
#include <hal/spinal/uart/uart.hpp>
#include <include/device.hpp>

#include <chrono>

namespace soc
{

    static hal::riscv::clint clint(CLINT);
    static hal::riscv::plic plic(PLIC);
    static hal::spinal::uart uart(UART_A);

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
        clint.delay(duration, SYSTEM_HZ);
    }

}
