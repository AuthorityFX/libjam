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
