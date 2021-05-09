include_guard()

include(FetchContent)

###########################################
# Fetch dependencies
###########################################
FetchContent_Declare(Catch2
    GIT_REPOSITORY git@github.com:unixod/Catch2.git
    GIT_TAG e140ebc142836fbda199d80a6593a126e6d29a2f # branch: fix-warnings (hash is used to prevent fetching each time cmake is run)
    GIT_SHALLOW On
)

FetchContent_Declare(unixod-cmake-modules
    GIT_REPOSITORY git@github.com:unixod/cmake-modules.git
    GIT_TAG cf11eb12630ccce9fcab08ce360d34a9e4606c3f
    GIT_SHALLOW On
)

FetchContent_MakeAvailable(
    Catch2
    unixod-cmake-modules
)

###########################################
# Add ez::tests_config
###########################################
add_library(ez_tests_config INTERFACE)
add_library(ez::tests_config ALIAS ez_tests_config)

# Enforce /EHsc in case compiler flags were overriten by CMAKE_CXX_FLAGS
# e.g. see: https://github.com/skvadrik/re2c/pull/339#issuecomment-752357341
if(MSVC)
    target_compile_options(ez_tests_config
        PUBLIC
        /EHsc
    )
endif()

target_link_libraries(ez_tests_config
    INTERFACE
    Catch2WithMain)
