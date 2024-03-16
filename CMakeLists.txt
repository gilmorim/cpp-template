cmake_minimum_required(VERSION 3.21)

project(
    "CppTemplate"
    VERSION 1.0.0
    LANGUAGES C CXX)

# Global CMake variables are set here
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Options
option(USE_CPM "Whether to use CPM." ON)

option(ENABLE_WARNINGS "Enable to add warnings to a target." ON)
option(ENABLE_WARNINGS_AS_ERRORS "Enable to treat warnings as errors." OFF)

option(ENABLE_TESTING "Enable a Unit Testing build." ON)

option(ENABLE_CLANG_TIDY "Enable to add clang tidy." ON)

option(ENABLE_SANITIZE_ADDR "Enable address sanitize." OFF)
option(ENABLE_SANITIZE_UNDEF "Enable undefined sanitize." OFF)
option(ENABLE_SANITIZE_LEAK "Enable leak sanitize (Gcc/Clang only)." OFF)
option(ENABLE_SANITIZE_THREAD "Enable thread sanitize (Gcc/Clang only)." OFF)

option(ENABLE_CLANG_FORMAT "Enable to add clang-format." ON)

option(ENABLE_LTO "Enable to add Link Time Optimization." ON)

# Project/Library Names
set(LIBRARY_NAME "lib")
set(UNIT_TEST_NAME "unit_tests")
set(EXECUTABLE_NAME "main")

# CMAKE MODULES
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/)
include(ConfigSafeGuards)
include(AddGitSubmodule)
include(Docs)
include(Tools)

if(ENABLE_WARNINGS)
    include(Warnings)
endif()

add_clang_format_target()

if(ENABLE_SANITIZE_ADDR OR ENABLE_SANITIZE_UNDEF)
    include(Sanitizer)
    add_sanitizer_flags()
endif()

if(ENABLE_LTO)
    include(LTO)
endif()

# EXTERNAL LIBRARIES
if(USE_CPM)
    message(STATUS "Using CPM")
    include(CPM)
    cpmaddpackage("gh:fmtlib/fmt#9.1.0")
    cpmaddpackage("gh:nlohmann/json@3.11.2")
    cpmaddpackage("gh:catchorg/Catch2@2.13.9")
    cpmaddpackage("gh:jarro2783/cxxopts@3.1.1")
    cpmaddpackage("gh:gabime/spdlog@1.11.0")
else()
    message(STATUS "Using FetchContent")
        FetchContent_Declare(
            nlohmann_json
            GIT_REPOSITORY https://github.com/nlohmann/json
            GIT_TAG v3.11.3
            GIT_SHALLOW TRUE)
        FetchContent_MakeAvailable(nlohmann_json)

        FetchContent_Declare(
            fmt
            GIT_REPOSITORY https://github.com/fmtlib/fmt
            GIT_TAG 10.0.0
            GIT_SHALLOW TRUE)
        FetchContent_MakeAvailable(fmt)

        FetchContent_Declare(
            spdlog
            GIT_REPOSITORY https://github.com/gabime/spdlog
            GIT_TAG v1.13.0
            GIT_SHALLOW TRUE)
        FetchContent_MakeAvailable(spdlog)

        FetchContent_Declare(
            cxxopts
            GIT_REPOSITORY https://github.com/jarro2783/cxxopts
            GIT_TAG v3.1.1
            GIT_SHALLOW TRUE)
        FetchContent_MakeAvailable(cxxopts)

        if(ENABLE_TESTING)
            FetchContent_Declare(
                Catch2
                GIT_REPOSITORY https://github.com/catchorg/Catch2
                GIT_TAG v3.5.3
                GIT_SHALLOW TRUE)
            FetchContent_MakeAvailable(Catch2)
            list(APPEND CMAKE_MODULE_PATH ${catch2_SOURCE_DIR}/extras)
        endif()
endif()

# SUB DIRECTORIES

add_subdirectory(configured)
add_subdirectory(src)
add_subdirectory(app)
add_subdirectory(tests)
