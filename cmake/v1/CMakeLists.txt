# cmake version requirement
cmake_minimum_required(VERSION 2.8)

# project info
project(add)

# find cpps
aux_source_directory(. CPPS)

# create exe
add_executable(add ${CPPS})
