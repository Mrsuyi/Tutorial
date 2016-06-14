#include <iostream>
#include <stdexcept>
#include <sstream>

#include <thrift/concurrency/ThreadManager.h>
#include <thrift/concurrency/PlatformThreadFactory.h>
#include <thrift/protocol/TBinaryProtocol.h>
#include <thrift/server/TSimpleServer.h>
#include <thrift/server/TThreadPoolServer.h>
#include <thrift/server/TThreadedServer.h>
#include <thrift/transport/TServerSocket.h>
#include <thrift/transport/TSocket.h>
#include <thrift/transport/TTransportUtils.h>
#include <thrift/TToString.h>

#include <boost/make_shared.hpp>

#include "gen-cpp/Calc.h"
#include "gen-cpp/Calc_types.h"

using namespace std;
using namespace apache::thrift;
using namespace apache::thrift::concurrency;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;
using namespace apache::thrift::server;

using namespace calc;

class CalcHandler : public CalcIf
{
    void calculate(Result& ret, const Operation::type oper, const int32_t a, const int32_t b)
    {
        switch (oper)
        {
            case Operation::ADD:
                ret.value = a + b;
                ret.comment = "add";
                break;

            case Operation::DEC:
                ret.value = a - b;
                ret.comment = "dec";
                break;

            case Operation::MUL:
                ret.value = a * b;
                ret.comment = "mul";
                break;

            case Operation::DIV:
                if (b == 0)
                {
                    CalcError err;
                    err.what = "div 0";
                    err.oper = Operation::DIV;
                    throw err;
                }

                ret.value = a / b;
                ret.comment = "div";

                break;

            default:
                ;
        }
    }
};

int main(int argc, char* argv[])
{
    cout << "server begin on " << atoi(argv[1]) << endl;

    TThreadedServer server
    (
        boost::make_shared<CalcProcessor>(boost::make_shared<CalcHandler>()),
        boost::make_shared<TServerSocket>(atoi(argv[1])),
        boost::make_shared<TBufferedTransportFactory>(),
        boost::make_shared<TBinaryProtocolFactory>()
    );

    server.serve();

    cout << "server end" << endl;
}
