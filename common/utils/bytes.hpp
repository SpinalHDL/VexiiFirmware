#pragma once

#include <cstddef>
#include <span>
#include <string_view>

namespace utils
{

    [[nodiscard]]
    std::span<const std::byte>
    to_bytes(const std::string_view str)
    {
        // Sanity check
        // ToDo: Use concept instead
        static_assert(sizeof(decltype(str)::value_type) == 1, "string must be narrow.");

        return std::span<const std::byte>{
            reinterpret_cast<const std::byte*>(std::data(str)),
            std::size(str)
        };
    }

}
