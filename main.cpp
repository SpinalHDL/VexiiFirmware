#include <array>
#include <cstddef>
#include <cstdint>
#include <string>
#include <span>

extern "C"
void
trap()
{

}

template<std::size_t N>
struct foo
{
    foo()
    {
        m_data[0] = N;
        m_data[1] = 1;
        m_data[2] = 2;
        m_data[3] = 3;
        m_data[4] = 4;
    }

    [[nodiscard]]
    constexpr
    std::span<const std::uint8_t, N>
    get() const noexcept
    {
        return m_data;
    }

private:
    std::array<std::uint8_t, N> m_data;
};


[[noreturn]]
int
main()
{
    foo<8> f1;

    int i = 0;

    auto d = f1.get();

    while (true) {
        i++;
    }
}
