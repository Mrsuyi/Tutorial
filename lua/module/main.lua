--local module = require("module")

local local_var  = "this is local var";
      global_var = "this is global var";

-- required module will only execute once, just like js
-- so if you require in the top, $vars won't be modified
local module = require("module")

print(local_var)
print(global_var)

shit()
module.fuck()
