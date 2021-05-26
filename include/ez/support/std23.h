/*
 * A set of features from C++23
 */

#ifndef EZ_SUPPORT_CPP23_FEATURES_H
#define EZ_SUPPORT_CPP23_FEATURES_H

#include <type_traits>

namespace ez::support::std23 {

// <utility>

template<typename Enum>
constexpr auto to_underlying(Enum e) noexcept
{
    static_assert(std::is_enum_v<Enum>);
    return static_cast<std::underlying_type_t<Enum>>(e);
}


// <type_traits>

template<typename E>
struct is_scoped_enum : std::false_type {};

template<typename E>
requires std::is_enum_v<E>
struct is_scoped_enum<E> :
        std::negation<
            std::is_convertible<E, std::underlying_type_t<E>>
        > {};

template<typename E>
inline constexpr auto is_scoped_enum_v = is_scoped_enum<E>::value;

} // namespace ez::support::std23

#endif //EZ_SUPPORT_CPP23_FEATURES_H
