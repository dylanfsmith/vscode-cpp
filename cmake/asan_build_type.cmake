#################################################
## Define "ASan" build type for CMake.
##
## Derived from Debug build type.
#################################################

set(CMAKE_C_FLAGS_ASAN
	"${CMAKE_C_FLAGS_DEBUG} -fsanitize=address -fsanitize=leak -fno-omit-frame-pointer" CACHE STRING
	"C compiler flags for ASan build type." FORCE
)
set(CMAKE_CXX_FLAGS_ASAN
	"${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=address -fsanitize=leak -fno-omit-frame-pointer" CACHE STRING
	"C++ compiler flags for ASan build type." FORCE
)
set(CMAKE_EXE_LINKER_FLAGS_ASAN
	"${CMAKE_SHARED_LINKER_FLAGS_DEBUG} -fsanitize=address -fsanitize=leak" CACHE STRING
	"Executable linker flags for ASan build type." FORCE
)
set(CMAKE_SHARED_LINKER_FLAGS_ASAN
	"${CMAKE_SHARED_LINKER_FLAGS_DEBUG} -fsanitize=address -fsanitize=leak" CACHE STRING
	"Shared library linker flags for ASan build type." FORCE
)
set(CMAKE_MODULE_LINKER_FLAGS_ASAN
	"${CMAKE_MODULE_LINKER_FLAGS_DEBUG} -fsanitize=address -fsanitize=leak" CACHE STRING
	"Module linker flags for ASan build type." FORCE
)
mark_as_advanced(
	CMAKE_C_FLAGS_ASAN
	CMAKE_CXX_FLAGS_ASAN
	CMAKE_EXE_LINKER_FLAGS_ASAN
	CMAKE_SHARED_LINKER_FLAGS_ASAN
	CMAKE_MODULE_LINKER_FLAGS_ASAN
)
