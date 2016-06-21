# cmake version requirement
cmake_minimum_required(VERSION 2.8)

# project info
project(add)

# find cpps
aux_source_directory(. SRCS)
# create exe
add_executable(main.exe ${SRCS})

# custom compile option
option(USE_CALC "use libcalc for calculation ?" ON)

configure_file(
    # config file src path
    "${PROJECT_SOURCE_DIR}/config.h.in"
    # I used to compile in PROJECT_SOURCE_DIR/_build
    "${PROJECT_BINARY_DIR}/../config.h"
)

if (USE_CALC)
    add_subdirectory(calc)
    target_link_libraries(main.exe LIB_CALC)
endif (USE_CALC)

