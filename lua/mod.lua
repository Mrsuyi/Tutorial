module = {}

function module.log(name)
    print(name)
end

function module:log2(name)
    print(name)
end

return module
