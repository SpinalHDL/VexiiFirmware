#include <system/soc.hpp>
#include <utils/bytes.hpp>

[[noreturn]]
int
main()
{
    using namespace std::chrono_literals;

    soc::init();

    soc::uart.write(utils::to_bytes("Hello Vexii!\n"));

    while (true) {
        soc::delay(1ms);
        soc::uart.write(utils::to_bytes("*\n"));
    }
}
