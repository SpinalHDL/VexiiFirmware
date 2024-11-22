#pragma once

#include "../legacy/clint.h"    // ToDo: Temporary. Replace this with custom implementation.

#include <chrono>
#include <cstdint>

namespace hal
{

    struct clint
    {
        /**
         * The frequency at which the CLINT peripheral is running at.
         */
        // ToDo: Don't hardcode this!
        constexpr static const std::uint32_t frequency = 100'000'000;

        /**
         * Constructor.
         */
        constexpr
        explicit
        clint(const std::uintptr_t base_addr) :
            m_base_addr{ base_addr }
        {
        }

        /**
         * Get the current timer count.
         */
        [[nodiscard]]
        std::uint64_t
        count() const
        {
            return clint_getTime(m_base_addr);
        }

        /**
         * Configures the CLINT.
         */
        // ToDo: Either provide overload or change to accept std::chrono-something interval
        void
        setup(const std::uint64_t cmp, const std::uint32_t hart_id = 0)
        {
            clint_setCmp(m_base_addr, cmp, hart_id);
        }

        /**
         * Perform a blocking delay.
         */
        template<typename Rep, typename Period>
        void
        delay(const std::chrono::duration<Rep, Period> duration)
        {
            // Convert duration to µsec
            const auto usec = std::chrono::duration_cast<std::chrono::microseconds>(duration);

            clint_uDelay(
                static_cast<std::uint32_t>(usec.count()),
                frequency,
                m_base_addr
            );
        }

    private:
        std::uintptr_t m_base_addr = 0;
    };

}
