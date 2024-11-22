#include <hal/clint/clint.hpp>

#define CLINT  0x10010000

extern "C"
void
trap()
{

}

[[noreturn]]
int
main()
{
    using namespace std::chrono_literals;

    hal::clint clint(CLINT);

    clint.setup(100'000'000);

    while (true) {
        clint.delay(10ms);
    }
}
