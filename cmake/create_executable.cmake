
macro(create_executable target_name target_source)
	message(STATUS "creating ${target_name} with ${target_source}")
	add_executable(${target_name} ${target_source})
	target_link_libraries(${target_name} dynamo pthread systemd form ncurses )
	set_target_properties(${target_name} PROPERTIES OUTPUT_NAME ${target_name}${BUILD_POSTFIX})
endmacro(create_executable)
