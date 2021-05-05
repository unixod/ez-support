include_guard()

add_subdirectory(third-party/Catch2)
add_library(mp::tests_config ALIAS Catch2WithMain)

list(APPEND CMAKE_MODULE_PATH
    ${CMAKE_SOURCE_DIR}/cmake)

# Enforce /EHsc in case compiler flags were overriten by CMAKE_CXX_FLAGS
# e.g. see: https://github.com/skvadrik/re2c/pull/339#issuecomment-752357341
if(MSVC)
    target_compile_options(Catch2WithMain
        PUBLIC
        /EHsc
    )
endif()

include(addTest)
