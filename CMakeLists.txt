cmake_minimum_required(VERSION 3.23)

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

cmake_dependent_option(EZ_SUPPORT_INSTALL
    "Generate an install target for ez::support" Off "NOT EZ_SUPPORT_STANDALONE" On)

# C++ standard configuration
if(CMAKE_CXX_STANDARD VERSION_LESS 20)
    set(CMAKE_CXX_STANDARD 20)
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
    ez::support::compile_options
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
