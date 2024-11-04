#pragma once

#include <cstdint>

namespace hal
{

    struct gpio
    {
        /**
         * Constructor.
         */
        explicit
        constexpr
        gpio(const std::uint32_t base_addr) :
            m_base_addr{ base_addr }
        {
        }

    private:
        std::uint32_t m_base_addr = 0;
    };

}
