include_guard()

###############################################################################
# Define ez::tests_config
###############################################################################

add_library(ez_support_tests_config INTERFACE)
add_library(ez::support::tests_config ALIAS ez_support_tests_config)

target_link_libraries(ez_support_tests_config
    INTERFACE
    ez::catch
    ez::support::private_compile_options
)
