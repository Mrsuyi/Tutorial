local mod = require("mod")

local str = 'fuck'
local str2 = "shit"

mod.log(str)
mod.log(str2)

mod.log2(mod, str)
mod.log2(mod, str2)

mod:log2(str)
mod:log2(str2)
