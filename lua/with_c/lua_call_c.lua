-- scritp lua

print("lua: file init")

function calc(a, b, c)
    print("lua: begin calc");

    sum, avg = sum_avg(a, b, c);
    print("lua: sum = " .. sum)
    print("lua: avg = " .. avg)

    print("lua: end calc");
    return sum, avg
end
