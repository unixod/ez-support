include_guard()

include(FetchContent)

FetchContent_Declare(ez-common
    GIT_REPOSITORY https://github.com/unixod/ez-common.git
    GIT_TAG v1.1.0
    GIT_SHALLOW On
)

FetchContent_MakeAvailable(ez-common)


if(EZ_SUPPORT_STANDALONE AND BUILD_TESTING)
    FetchContent_Declare(ez-catch
        GIT_REPOSITORY https://github.com/unixod/ez-catch.git
        GIT_TAG v3.2.1
        GIT_SHALLOW On
    )

    FetchContent_MakeAvailable(ez-catch)
endif()
