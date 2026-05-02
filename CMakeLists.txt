cmake_minimum_required(VERSION 3.10)

project(SentinelAPI C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

add_library(sentinel_api STATIC
    sentinel_api.c
)

target_include_directories(sentinel_api PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)
