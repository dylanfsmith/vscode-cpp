cmake_minimum_required(VERSION 3.16)

# Define our C++ project.
# Make sure to include C as a language or our build rules will not apply to
# any external (or internal) C code we might include later.
project(vscode-cpp
	VERSION 1.0
	DESCRIPTION "Example of using VSCode with CMake and C++."
	LANGUAGES C CXX
)

# Group our targets together in top-level build-specific directories.
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Add C++20 support and warnings
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_FLAGS "-Wall -Wextra -Werror -pedantic-errors -fsignaling-nans -std=c++2a")

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})
# Don't include .cmake extension for cmake files in module path
include(build_types)
include(create_executable)

# Install Catch2 testing library
include(FetchContent)
FetchContent_Declare(
	Catch2
	GIT_REPOSITORY https://github.com/catchorg/Catch2.git
	GIT_TAG        v3.0.1 # or a later release
)
FetchContent_MakeAvailable(Catch2)
# This is not enough 

include_directories(src)
add_executable(tests 
	src/test/add_test.cpp
	src/test_main.cpp
)
target_link_libraries(tests PRIVATE Catch2::Catch2)
