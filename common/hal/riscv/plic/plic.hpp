#pragma once

#include "../../legacy/plic.h"    // ToDo: Temporary. Replace this with custom implementation.

#include <cstdint>

namespace hal
{
    namespace riscv
    {
        struct plic
        {
            /**
             * Constructor.
             */
            constexpr
            explicit
            plic(const std::uintptr_t base_addr) :
                m_base_addr{ base_addr }
            {
            }

            void
            set_priority(const std::uint32_t gateway, const std::uint32_t priority)
            {
                plic_set_priority(m_base_addr, gateway, priority);
            }

            void
            set_enable(const std::uint32_t target, const std::uint32_t gateway, bool enabled)
            {
                plic_set_enable(m_base_addr, target, gateway, (enabled ? 1 : 0));
            }

            void
            set_threshold(const std::uint32_t target, const std::uint32_t threshold)
            {
                plic_set_threshold(m_base_addr, target, threshold);
            }

            /**
             * Lets a target claim a gateway.
             *
             * @return the gateway ID.
             */
            [[nodiscard]]
            std::uint32_t
            claim(const std::uint32_t target)
            {
                return plic_claim(m_base_addr, target);
            }

            void
            release(const std::uint32_t target, const std::uint32_t gateway)
            {
                plic_release(m_base_addr, target, gateway);
            }

        private:
            std::uintptr_t m_base_addr = 0;
        };
    }
}
