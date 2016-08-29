local_var  = "this is local var2";
global_var = "this is global var2";

function shit()
    print("shit")
end

local function fuck()
    print("fuck") 
end

export =
{
    fuck = fuck
}

return export
