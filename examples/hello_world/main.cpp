#include <system/soc.hpp>

[[noreturn]]
int
main()
{
    using namespace std::chrono_literals;

    soc::init();

    while (true) {
        soc::delay(10ms);
    }
}
