#pragma once

#include <cstdint>

namespace hal
{
    namespace spinal
    {
        struct gpio
        {
            /**
             * Constructor.
             */
            explicit
            constexpr
            gpio(const std::uintptr_t base_addr) :
                m_base_addr{ base_addr }
            {
            }

        private:
            std::uintptr_t m_base_addr = 0;
        };
    }

}
