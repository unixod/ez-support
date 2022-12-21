include_guard()

include(FetchContent)

if(EZ_SUPPORT_STANDALONE AND BUILD_TESTING)
    FetchContent_Declare(ez-catch
        GIT_REPOSITORY https://github.com/unixod/ez-catch.git
        GIT_TAG v3.2.1
        GIT_SHALLOW On
    )

    FetchContent_MakeAvailable(ez-catch)
endif()
