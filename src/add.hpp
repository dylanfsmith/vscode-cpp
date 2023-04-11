#pragma once

namespace vscode_cpp {

/// Add any number of arguments
template <typename... Args>
auto add(Args... args) {
	return (args + ...);
}

} // namespace vscode_cpp
