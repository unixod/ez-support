cmake_minimum_required(VERSION 3.13)
project(ez VERSION 1.0.0)

# Check if this is a standalone project or included by other project
if (CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    set(EZ_STANDALONE On)
endif()

include(GNUInstallDirs)

if (EZ_STANDALONE)
    include(CTest)

    if (BUILD_TESTING AND EZ_STANDALONE)
        include(tests-config.cmake)
    endif()
endif()

include(compile-options.cmake)

add_subdirectory(ez)
