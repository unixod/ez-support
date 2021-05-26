#include "ez/support/std23.h"
#include <catch2/catch_all.hpp>
#include <catch2/generators/catch_generators_range.hpp>

TEST_CASE("std23::to_underlying")
{
    enum struct Enum {};

    auto i = GENERATE(Catch::Generators::range(-3, 3));

    REQUIRE(i <=  std::numeric_limits<std::underlying_type_t<Enum>>::max());

    REQUIRE(ez::support::std23::to_underlying(Enum{i}) == i);
}

TEST_CASE("std23::is_scoped_enum")
{
    enum NotScopedEnum {};
    enum struct ScopedEnum {};

    REQUIRE_FALSE(ez::support::std23::is_scoped_enum<NotScopedEnum>::value);
    REQUIRE_FALSE(ez::support::std23::is_scoped_enum_v<NotScopedEnum>);

    REQUIRE(ez::support::std23::is_scoped_enum<ScopedEnum>::value);
    REQUIRE(ez::support::std23::is_scoped_enum_v<ScopedEnum>);
}
