#include "add.hpp"

#include <catch2/catch_all.hpp>

namespace vscode_cpp {
namespace {

TEST_CASE("add", "[small]") {

	SECTION("ints") {
		CHECK(add(1,2,3) == 6);
	}

	SECTION("floats") {
		CHECK(add(1.,2.,3.) == 6.);
	}

	SECTION("mixed") {
		CHECK(add(1,2u,3.) == 6.);
	}
}

}	
}
