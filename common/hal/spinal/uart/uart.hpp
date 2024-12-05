#pragma once

#include "../../legacy/uart.h"        // ToDo: Temporary, implement everything ourselves instead

#include <cstdint>
#include <cstddef>
#include <span>

namespace hal
{
    namespace spinal
    {
        struct uart
        {
            constexpr
            explicit
            uart(const std::uintptr_t base_addr) :
                m_base_addr{ base_addr }
            {
            }

            [[nodiscard]]
            std::uint32_t
            rx_fifo_capacity() const
            {
                return 0;   // ToDo
            }

            [[nodiscard]]
            std::uint32_t
            rx_fifo_size() const
            {
                return uart_readOccupancy(m_base_addr);
            }

            [[nodiscard]]
            std::uint32_t
            tx_fifo_capacity() const
            {
                return 0;   // ToDo
            }

            [[nodiscard]]
            std::uint32_t
            tx_fifo_size()
            {
                return uart_writeAvailability(m_base_addr);
            }

            // ToDo: Directly access registers ourselves, don't use old C API.
            void
            write(const std::span<const std::byte> data)
            {
                for (const auto& b : data)
                    uart_write(m_base_addr, static_cast<char>(b));
            }

            // ToDo: Directly access registers ourselves, don't use old C API.
            void
            read(const std::span<std::byte> data)
            {
                for (auto& b : data)
                    b = static_cast<std::byte>(uart_read(m_base_addr));
            }

        private:
            std::uintptr_t m_base_addr = 0;
        };
    }
}
