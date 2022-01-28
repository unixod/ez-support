##################################################
# Define ez::support::compile_options - a target
# representing a set of common compile options 
# for a project.
##################################################

include_guard()

add_library(ez_support_compile_options INTERFACE)
add_library(ez::support::compile_options ALIAS ez_support_compile_options)

if(NOT EZ_SUPPORT_STANDALONE)
    # use client defined options.
elseif(MSVC)
    target_compile_options(ez_support_compile_options
        INTERFACE
        /EHsc
        /Wall
        /WX
        /Zc:__cplusplus
    )
else()
    target_compile_options(ez_support_compile_options
        INTERFACE
        -Wall
        -Wcast-align
        -Wconversion
        -Werror
        -Wextra
        -Wnon-virtual-dtor
        -Wold-style-cast
        -Woverloaded-virtual
        -Wpedantic
        -Wshadow
        -Wsign-conversion
    )
endif()

target_compile_features(ez_support_compile_options INTERFACE cxx_std_20)

install(TARGETS ez_support_compile_options EXPORT ez-libs)
set_target_properties(ez_support_compile_options
    PROPERTIES
    EXPORT_NAME support_compile_options)

