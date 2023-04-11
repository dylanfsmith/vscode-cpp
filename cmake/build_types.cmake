include(asan_build_type)
include(tsan_build_type)
include(gcov_build_type)

set(ALLOWED_BUILD_TYPES Debug Release RelWithDebInfo ASan TSan GCov)
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "${ALLOWED_BUILD_TYPES}")
if (CMAKE_BUILD_TYPE AND NOT CMAKE_BUILD_TYPE IN_LIST ALLOWED_BUILD_TYPES)
	message(FATAL_ERROR "Invalid build type: ${CMAKE_BUILD_TYPE}")
endif()

set(BUILD_POSTFIX $<$<CONFIG:Debug>:_d>$<$<CONFIG:Release>:_r>$<$<CONFIG:RelWithDebInfo>:_rd>$<$<CONFIG:ASan>:_s>)
