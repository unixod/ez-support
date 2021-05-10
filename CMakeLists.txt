cmake_minimum_required(VERSION 3.13)
project(ez-support VERSION 1.0.0)

# Check if this is a standalone project or included by other project
if (CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    set(EZ_STANDALONE On)
endif()

include(GNUInstallDirs)

include(compile-options.cmake)

add_library(ez_support INTERFACE)
add_library(ez::support ALIAS ez_support)

target_include_directories(ez_support
    INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/include>)

target_link_libraries(ez_support
    INTERFACE
    ez::support::compile_options)

if (EZ_STANDALONE)
    include(CTest)

    if (BUILD_TESTING)
        include(tests-config.cmake)
        add_subdirectory(tests)
    endif()
endif()


