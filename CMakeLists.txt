cmake_minimum_required(VERSION 3.16)

project(ez-support
    VERSION 1.0.0
    LANGUAGES CXX
)

include(GNUInstallDirs)

##############################################################################
# Setup project general properties
##############################################################################

# Check if this is a standalone project or included by other project
if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
    set(EZ_SUPPORT_STANDALONE On)
endif()

# Although this library is supposed to be dependency free its unit tests
# are based on Catch2 unit test framework. Specifying CMAKE_CXX_STANDARD
# in the following block is necessary for correct building of and linking
# with Catch2 and potentialy any other fetched dependency because they
# need to be informed somehow about the C++ standard being used.
if(EZ_SUPPORT_STANDALONE AND NOT DEFINED CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 20)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    set(CMAKE_CXX_EXTENSIONS OFF)
endif()

##############################################################################
# Setup ez::support target
##############################################################################
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

install(DIRECTORY include DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(TARGETS ez_support EXPORT ez-support)
set_target_properties(ez_support
    PROPERTIES
    EXPORT_NAME support)

install(EXPORT ez-support
    NAMESPACE ez::
    DESTINATION lib/ez
    FILE support.cmake)

##############################################################################
# Setup unit tests
##############################################################################
if(EZ_SUPPORT_STANDALONE)
    include(CTest)

    if (BUILD_TESTING)
        include(tests-config.cmake)
        add_subdirectory(tests)
    endif()
endif()
