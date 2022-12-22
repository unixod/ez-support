cmake_minimum_required(VERSION 3.24)

project(ez-support
    VERSION 1.0.1
    LANGUAGES CXX
)

include(GNUInstallDirs)
include(CMakeDependentOption)

##############################################################################
# Setup project general properties
##############################################################################

# Check if this is a standalone project or included by other project
if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    set(EZ_SUPPORT_STANDALONE On)
    include(CTest)
endif()

# If ez-support is used by some outer project (e.g. via CMake FetchContent or add_subdirectory)
# then don't register targets defined here to be installed until it is explicitelly requested by
# the outer project by setting EZ_SUPPORT_INSTALL option to On.
cmake_dependent_option(EZ_SUPPORT_INSTALL
    "Generate an install target for ez::support" Off "NOT EZ_SUPPORT_STANDALONE" On)

# Require C++20 or higher.
# Notes:
# - CMAKE_CXX_STANDARD is for dependencies (for now it's only Catch2).
# - cxx_std_${EZ_SUPPORT_CPP_MINIMUM_REQUIRED} (in compile-options.cmake) is for ez-support and for
#   its consumers (i.e. dependent targets).
set(EZ_SUPPORT_CPP_MINIMUM_REQUIRED 20)
if(CMAKE_CXX_STANDARD VERSION_LESS ${EZ_SUPPORT_CPP_MINIMUM_REQUIRED})
    set(CMAKE_CXX_STANDARD ${EZ_SUPPORT_CPP_MINIMUM_REQUIRED})
endif()
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(dependencies.cmake)
include(compile-options.cmake)

##############################################################################
# Setup ez::support target
##############################################################################

add_library(ez_support INTERFACE)
add_library(ez::support ALIAS ez_support)

target_sources(ez_support
    INTERFACE
    FILE_SET HEADERS
    BASE_DIRS include
    FILES
        include/ez/support/std23.h
        include/ez/support/definitions.h
)

target_link_libraries(ez_support
    INTERFACE
    ez::support::public_compile_options
)

if(EZ_SUPPORT_INSTALL)
    install(TARGETS ez_support EXPORT ez-libs
        FILE_SET HEADERS
    )

    set_target_properties(ez_support
        PROPERTIES
        EXPORT_NAME support
    )

    install(EXPORT ez-libs
        NAMESPACE ez::
        DESTINATION lib/ez
        FILE libs.cmake
    )
endif()

##############################################################################
# Setup unit tests
##############################################################################
if(EZ_SUPPORT_STANDALONE AND BUILD_TESTING)
    include(tests-config.cmake)
    add_subdirectory(tests)
endif()
