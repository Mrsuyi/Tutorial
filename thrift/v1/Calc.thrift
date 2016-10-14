namespace cpp calc

struct Result
{
    1: i32    value,
    2: string comment
}

enum Operation
{
    ADD = 1,
    DEC = 2,
    MUL = 3,
    DIV = 4
}

exception CalcError
{
    1: Operation oper,
    2: string    str
}

service Calc
{
    Result calculate(1: Operation oper, 2: i32 a, 3: i32 b) throws (1: CalcError err)
}
