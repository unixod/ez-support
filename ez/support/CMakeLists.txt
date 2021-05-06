add_library(support INTERFACE)
add_library(ez::support ALIAS support)

target_include_directories(support
    INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/include>)

if(BUILD_TESTING)
    add_subdirectory(tests)
endif()
