include_guard()

include(FetchContent)
FetchContent_Declare(
    Catch2
    GIT_REPOSITORY git@github.com:unixod/Catch2.git
    GIT_TAG fix-warnings
    GIT_SHALLOW On
)

FetchContent_MakeAvailable(Catch2)

#add_subdirectory(third-party/Catch2)
add_library(ez::tests_config ALIAS Catch2WithMain)

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
