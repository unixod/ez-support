#ifndef EZ_SUPPORT_DEFINITIONS_H
#define EZ_SUPPORT_DEFINITIONS_H

#include <cassert>

#define STRINGIFY1(x) #x
#define STRINGIFY(x) STRINGIFY1(x)

#ifdef NDEBUG
#   define ERR_MSG
#else
#   define ERR_MSG __FILE__ ":" STRINGIFY(__LINE__) ": "
#endif

#if defined(_MSC_VER)
#   define UNRECHABLE \
        assert(false && "Unreachable is reached"); \
        __assume(0)
#elif defined(__GNUC__) || defined(__clang__)
#   define UNRECHABLE \
        assert(false && "Unreachable is reached"); \
        __builtin_unreachable()
#else
#   warning "UNRECHABLE macro may have no effect due to unable to detect used compiler."
#   define UNRECHABLE \
        assert(false && "Unreachable is reached");
#endif

#endif // EZ_SUPPORT_DEFINITIONS_H
