#include <stdio.h>
#include <time.h>
#include <assert.h>
#include <unistd.h>

int main()
{
    // [time_t] does not have a standard definition
    // usually it stores the seconds since epoc(1970-1-1 00:00)
    time_t t = time(NULL);

    // localtime
    struct tm* ptm = localtime(&t);
    printf("localtime:\n"
           "\tsecond: %d\n"
           "\tmin: %d\n"
           "\thour: %d\n"
           "\tday of month: %d\n"
           "\tmonth: %d\n"
           "\tyear: %d\n"
           "\tday of week: %d\n"
           "\tday of year: %d\n"
           "\tis DST: %d\n",
           ptm->tm_sec,
           ptm->tm_min,
           ptm->tm_hour,
           ptm->tm_mday,
           ptm->tm_mon,
           ptm->tm_year,
           ptm->tm_wday,
           ptm->tm_yday,
           ptm->tm_isdst);

    // gmtime
    ptm = gmtime(&t);
    printf("\n");
    printf("localtime:\n"
           "\tsecond: %d\n"
           "\tmin: %d\n"
           "\thour: %d\n"
           "\tday of month: %d\n"
           "\tmonth: %d\n"
           "\tyear: %d\n"
           "\tday of week: %d\n"
           "\tday of year: %d\n"
           "\tis DST: %d\n",
           ptm->tm_sec,
           ptm->tm_min,
           ptm->tm_hour,
           ptm->tm_mday,
           ptm->tm_mon,
           ptm->tm_year,
           ptm->tm_wday,
           ptm->tm_yday,
           ptm->tm_isdst);

    // mktime
    time_t t2 = mktime(ptm);
    ptm = localtime(&t2);

    // asctime
    printf("\n");
    printf("asctime %s\n", asctime(ptm));

    // ctime
    printf("ctime %s\n", ctime(&t));

    // strftime
    size_t len = sizeof("2000-01-01T00:00:00Z");
    char str[len];
    assert(strftime(str, len, "%FT%TZ", ptm) == len - 1);
    printf("strftime %s\n", str);

    // difftime
    sleep(1);
    time_t t3 = time(NULL);
    printf("\n");
    printf("difftime %lf\n", difftime(t3, t));

    // clock
    printf("\n");
    clock_t clk_bgn = clock();
    sleep(1);
    clock_t clk_end = clock();
    printf("clock diff %lf ms\n", 1000.0 * (clk_end - clk_bgn) / CLOCKS_PER_SEC);

    return 0;
}
