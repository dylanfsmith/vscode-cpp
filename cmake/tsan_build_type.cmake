#################################################
## Define "TSan" build type for CMake.
##
## Derived from Debug build type.
#################################################

set(CMAKE_C_FLAGS_TSAN
	"${CMAKE_C_FLAGS_DEBUG} -fsanitize=thread -fno-omit-frame-pointer" CACHE STRING
	"C compiler flags for TSan build type." FORCE
)
set(CMAKE_CXX_FLAGS_TSAN
	"${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=thread -fno-omit-frame-pointer" CACHE STRING
	"C++ compiler flags for TSan build type." FORCE
)
set(CMAKE_EXE_LINKER_FLAGS_TSAN
	"${CMAKE_SHARED_LINKER_FLAGS_DEBUG} -fsanitize=thread" CACHE STRING
	"Executable linker flags for TSan build type." FORCE
)
set(CMAKE_SHARED_LINKER_FLAGS_TSAN
	"${CMAKE_SHARED_LINKER_FLAGS_DEBUG} -fsanitize=thread" CACHE STRING
	"Shared library linker flags for TSan build type." FORCE
)
set(CMAKE_MODULE_LINKER_FLAGS_TSAN
	"${CMAKE_MODULE_LINKER_FLAGS_DEBUG} -fsanitize=thread" CACHE STRING
	"Module linker flags for TSan build type." FORCE
)
mark_as_advanced(
	CMAKE_C_FLAGS_TSAN
	CMAKE_CXX_FLAGS_TSAN
	CMAKE_EXE_LINKER_FLAGS_TSAN
	CMAKE_SHARED_LINKER_FLAGS_TSAN
	CMAKE_MODULE_LINKER_FLAGS_TSAN
)
