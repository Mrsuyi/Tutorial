parent = {}

function parent:new(o, value)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.value = value or 123
    return o
end

function parent:show()
    print(self.value)
end

new = parent:new()
new:show()


child = parent:new()

function child:new(o, value, name)
    o = o or parent:new(value)
    setmetatable(o, self)
    self.__index = self
    
    o.name = name or "shit"
    return o
end

function child:show()
    print(self.name .. " : " .. self.value)
end

new2 = child:new()
new2:show()
