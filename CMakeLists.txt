cmake_minimum_required(VERSION 3.16)
project(spatial_data_store)

set(CMAKE_CXX_STANDARD 17)

add_executable(spatial_data_store main.cpp)

find_package(PkgConfig REQUIRED)
pkg_check_modules(PQXX REQUIRED libpqxx)

include_directories(${PQXX_INCLUDE_DIRS})
link_directories(${PQXX_LIBRARY_DIRS})

target_link_libraries(spatial_data_store ${PQXX_LIBRARIES})

