#ifndef EZ_SUPPORT_CPP23_FEATURES_H
#define EZ_SUPPORT_CPP23_FEATURES_H

#include <type_traits>

namespace ez::std23 {

template<typename Enum>
constexpr auto to_underlying(Enum e) noexcept
{
    static_assert(std::is_enum_v<Enum>);
    return static_cast<std::underlying_type_t<Enum>>(e);
}

} // namespace ez::std23

#endif //EZ_SUPPORT_CPP23_FEATURES_H
