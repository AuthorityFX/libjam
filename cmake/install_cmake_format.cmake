include(install_pip_package)

# Install cmake-format using pip
function(install_cmake_format)
  if(${CMAKE_FORMAT_INSTALLED})
    return()
  endif()
  install_pip_package(NAME "cmake-format")
  set(CMAKE_FORMAT_INSTALLED
      true
      CACHE BOOL "cmake-format is installed"
  )
endfunction()
