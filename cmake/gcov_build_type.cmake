#################################################
## Define "GCov" build type for CMake.
##
## Derived from Debug build type.
#################################################

set(CMAKE_C_FLAGS_GCOV
	"${CMAKE_C_FLAGS_DEBUG} --coverage" CACHE STRING
	"C compiler flags for GCov build type." FORCE
)
set(CMAKE_CXX_FLAGS_GCOV
	"${CMAKE_CXX_FLAGS_DEBUG} --coverage" CACHE STRING
	"C++ compiler flags for GCov build type." FORCE
)
set(CMAKE_EXE_LINKER_FLAGS_GCOV
	"${CMAKE_EXE_LINKER_FLAGS_DEBUG} --coverage" CACHE STRING
	"Executable linker flags for GCov build type." FORCE
)
set(CMAKE_SHARED_LINKER_FLAGS_GCOV
	"${CMAKE_SHARED_LINKER_FLAGS_DEBUG} --coverage" CACHE STRING
	"Shared library linker flags for GCov build type." FORCE
)
set(CMAKE_MODULE_LINKER_FLAGS_GCOV
	"${CMAKE_MODULE_LINKER_FLAGS_DEBUG} --coverage" CACHE STRING
	"Module linker flags for GCov build type." FORCE
)
mark_as_advanced(
	CMAKE_C_FLAGS_GCOV
	CMAKE_CXX_FLAGS_GCOV
	CMAKE_EXE_LINKER_FLAGS_GCOV
	CMAKE_SHARED_LINKER_FLAGS_GCOV
	CMAKE_MODULE_LINKER_FLAGS_GCOV
)
