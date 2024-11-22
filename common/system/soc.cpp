#include "soc.hpp"

bool
soc::init()
{
    soc::clint.setup(100'000'000);  // ToDo

    return true;
}
