# Install a pip package
function(install_pip_package)
  cmake_parse_arguments(PIP_PACKAGE "" "NAME" "" ${ARGN})
  if(NOT PIP_PACKAGE_NAME)
    message(FATAL_ERROR "'NAME' keyword argument missing")
  endif()
  # check list of installed pip packages
  execute_process(
    COMMAND pip list
    OUTPUT_VARIABLE _output
    ERROR_VARIABLE _error
    RESULT_VARIABLE _return
  )
  # Throw is return code not 0
  if(NOT _return EQUAL 0)
    message(FATAL_ERROR ${_error})
  endif()
  # Regex for cmake-format in package list
  string(REGEX MATCH ${PIP_PACKAGE_NAME} _match ${_output})
  # If cmake-list not found in package list, install for user (avoid sudo)
  if(NOT _match)
    message(STATUS "Installing ${PIP_PACKAGE_NAME}")
    execute_process(
      COMMAND pip install --user ${PIP_PACKAGE_NAME} RESULT_VARIABLE _return
    )
  endif()
  # Throw is return code not 0
  if(NOT _return EQUAL 0)
    message(FATAL_ERROR ${_error})
  endif()
endfunction()
