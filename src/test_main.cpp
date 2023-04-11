#include <catch2/catch_session.hpp>

#include <vector>

int main(int argc, char * argv[]) {
	auto result = Catch::Session{}.run(argc, argv);
	return result;
}
