#include <stdio.h>

int main()
{
    printf("__FILE__ : %s\n", __FILE__);
    printf("__LINE__ : %d\n", __LINE__);
    printf("__func__ : %s\n", __func__);
    printf("__FUNCTION__ : %s\n", __FUNCTION__);
    printf("__PRETTY_FUNCTION__ : %s\n", __PRETTY_FUNCTION__);

    return 0;
}
