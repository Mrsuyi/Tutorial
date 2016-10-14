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

using namespace std;
using namespace apache::thrift;
using namespace apache::thrift::concurrency;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;
using namespace apache::thrift::server;

class CalcHandler : public CalcIf
{
    virtual int32_t add(const int32_t a, const int32_t b) override
    {
        cout << a << " + " << b << " = " << a + b + 1 << endl;
        return a + b + 1;
    }
};

int main(int argc, char* argv[])
{
    if (argc == 1)
    {
        printf("usage: %s <port>\n", argv[0]);
        exit(0);
    }
    printf("server listening on %s\n", argv[1]);

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
