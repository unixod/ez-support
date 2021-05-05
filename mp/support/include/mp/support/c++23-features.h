#include <type_traits>

namespace std23 {

template<typename Enum>
constexpr auto to_underlying(Enum e) noexcept
{
    static_assert(std::is_enum_v<Enum>);
    return static_cast<std::underlying_type_t<Enum>>(e);
}

} // namespace std23
