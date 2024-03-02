# Specify the minimum required version of CMake for this project. 
cmake_minimum_required(VERSION 3.14)

project(AUT_AP_2024_Spring_HW1)

# Set the C++ standard to C++23 and make it a required standard.
# If the compiler does not support C++23, CMake will produce an error.
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(GTest REQUIRED)

include_directories(include/)

add_executable(main
        src/main.cpp
        src/algebra.cpp
        src/unit_test.cpp
)

# Set compiler flags for C++.
# -Wall, -Wextra, -Werror, and -Wpedantic are used for stricter warnings and error handling.
set(CMAKE_CXX_FLAGS "-Wall -Wextra -Werror -Wpedantic")


# Set compiler flags specific to the Release build type.
# -O3 enables high-level optimizations.
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

target_link_libraries(main
        GTest::GTest
        GTest::Main
)
