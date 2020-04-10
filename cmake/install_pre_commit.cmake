include(install_pip_package)

# Install cmake-format using pip
function(install_pre_commit)
  if(${PRE_COMMIT_INSTALLED})
    return()
  endif()
  install_pip_package(NAME "pre-commit")
  set(PRE_COMMIT_INSTALLED
      true
      CACHE BOOL "pre-commit is installed"
  )
endfunction()
