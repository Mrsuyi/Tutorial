# cmake version requirement
cmake_minimum_required(VERSION 2.8)

# project info
project(add)

# find cpps
aux_source_directory(. SRCS)
# create exe
add_executable(main.exe ${SRCS})

# add sub-dir, inside which the CMakeLists.txt will be parsed
add_subdirectory(calc)
# add link library(created by sub-dir)
target_link_libraries(main.exe calc)
