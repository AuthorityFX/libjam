include(install_pip_package)

# Install cmake-format using pip
function(install_pre_commit)
  if(${PRE_COMMIT_INSTALLED})
    return()
  endif()
  install_pip_package(NAME "pre-commit")
  execute_process(COMMAND pre-commit install RESULT_VARIABLE _return)
  # Throw is return code not 0
  if(NOT _return EQUAL 0)
    message(FATAL_ERROR ${_error})
  endif()
  set(PRE_COMMIT_INSTALLED
      true
      CACHE BOOL "pre-commit is installed"
  )
endfunction()
