# Generate compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(install_pip_package)

# Install cmake-format using pip
function(install_compdb)
  if(${CMAKE_FORMAT_INSTALLED})
    return()
  endif()
  install_pip_package(NAME "compdb")
  set(CMAKE_FORMAT_INSTALLED
      true
      CACHE BOOL "compdb is installed"
  )
endfunction()
install_compdb()

# Add headers to compile_commands.json for use with clang tools
add_custom_target(
  compdb ALL
  DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json
  COMMENT "custom target"
)
add_custom_command(
  OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json
  COMMAND compdb -p build/ list > compile_commands.json
  VERBATIM
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
