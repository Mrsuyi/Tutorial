#pragma once

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

void fail(const char* fmt, ...)
{
    va_list argptr;
    va_start(argptr, fmt);
    fprintf(stderr, fmt, argptr);
    exit(-1);
}
