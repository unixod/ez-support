#include "ez/support/c++23-features.h"
#include <catch2/catch_all.hpp>
#include <catch2/generators/catch_generators_range.hpp>

TEST_CASE("std23::to_underlying")
{
    enum struct Enum {};

    auto i = GENERATE(Catch::Generators::range(-3, 3));

    REQUIRE(i <=  std::numeric_limits<std::underlying_type_t<Enum>>::max());

    REQUIRE(ez::std23::to_underlying(Enum{i}) == i);
}

