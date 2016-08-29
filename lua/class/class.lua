class = {}

function class:new(o, value)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.value = value or 123
    return o
end

function class:show()
    print(self.value)
end

new = class:new(nil, 234)
new:show()
