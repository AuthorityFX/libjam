# Force colored output for prettier Ninja console logging
function(force_colored_output)
  option(FORCE_COLORED_OUTPUT
         "Always produce ANSI-colored output (GNU/Clang only)." TRUE
  )
  if(${FORCE_COLORED_OUTPUT})
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
      add_compile_options(-fdiagnostics-color=always)
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
      add_compile_options(-fcolor-diagnostics)
    endif()
  endif()
endfunction()