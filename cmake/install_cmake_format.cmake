function(install_cmake_format)
  # Just return is cmake is already marked in cache as installed
  if (_cmake_format_installed EQUAL true)
    return()
  endif()
  # check list of installed pip packages
  execute_process(
    COMMAND
      pip list
    OUTPUT_VARIABLE
      _output
    ERROR_VARIABLE
      _error
    RESULT_VARIABLE
      _return
  )
  # Throw is return code not 0
  if (NOT _return EQUAL 0)
    message(FATAL_ERROR ${_error})
  endif()
  # Regex for cmake-format in package list
  string(
    REGEX MATCH
    "cmake-format"
    _match
    ${_output}
  )
  # If cmake-list not found in package list, install for user (avoid sudo)
  if (NOT _match)
    message(STATUS "Installing cmake-format")
    execute_process(
      COMMAND
        pip install --user cmake-format
      RESULT_VARIABLE
        _return
    )
  endif()
  # Set cache variable to true if _return code 0
  if (_return EQUAL 0)
    set(_cmake_format_installed true CACHE BOOL "cmake-format is installed")
  endif()
endfunction()
