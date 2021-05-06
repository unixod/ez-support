add_library(ez_support INTERFACE)
add_library(ez::support ALIAS ez_support)

target_include_directories(ez_support
    INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/include>)

target_link_libraries(ez_support
    INTERFACE
    ez::compile_options)

if (BUILD_TESTING AND EZ_STANDALONE)
    add_subdirectory(tests)
endif()

