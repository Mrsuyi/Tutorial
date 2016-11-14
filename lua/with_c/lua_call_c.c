#include <stdio.h>

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int sum_avg(lua_State* L)
{
    printf("c: begin sum_avg\n");

    int argc = lua_gettop(L);
    double res = 0;
    for (int i = 1; i <= argc; ++i)
    {
        if (!lua_isnumber(L, i))
        {
            lua_pushstring(L, "invalid argument");
            lua_error(L);
        }
        res += lua_tonumber(L, i);
    }
    lua_pushnumber(L, res);
    lua_pushnumber(L, res / argc);

    printf("c: end sum_avg\n");

    return 2;
}

int main()
{
    lua_State* l = luaL_newstate();

    if (l == NULL)
    {
        fprintf(stderr, "lua-new-state failed\n");
        return 0;
    }
    luaL_openlibs(l);
    if (luaL_loadfile(l, "lua_call_c.lua") != 0)
    {
        fprintf(stderr, "lua-load-file failed\n");
        return 0;
    }
    if (lua_pcall(l, 0, 0, 0) != 0)
    {
        fprintf(stderr, "lua-init-call failed\n");
        return 0;
    }

    // set c function
    lua_pushcfunction(l, sum_avg);
    lua_setglobal(l, "sum_avg");
    // push lua function
    lua_getglobal(l, "calc");
    lua_pushinteger(l, 1);
    lua_pushinteger(l, 2);
    lua_pushinteger(l, 3);

    if (lua_pcall(l, 3, 2, 0) != 0)
    {
        fprintf(stderr, "lua-func-call failed %s\n", lua_tostring(l, -1));
    }
    else
    {
        printf("c: sum = %lld\n", lua_tointeger(l, -2));
        printf("c: avg = %lld\n", lua_tointeger(l, -1));
        lua_pop(l, 2);
    }

    lua_close(l);

    return 0;
}

