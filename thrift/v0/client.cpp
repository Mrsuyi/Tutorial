#include <iostream>

#include <thrift/protocol/TBinaryProtocol.h>
#include <thrift/transport/TSocket.h>
#include <thrift/transport/TTransportUtils.h>

#include "gen-cpp/Calc.h"

using namespace std;
using namespace apache::thrift;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;

int main(int argc, char* argv[])
{
    if (argc < 3)
    {
        printf("usage: %s <ip> <port>\n", argv[0]);
        return 0;
    }
    printf("client connect to %s:%s\n", argv[1], argv[2]); 
    
    boost::shared_ptr<TTransport> socket(new TSocket(argv[1], atoi(argv[2])));
    boost::shared_ptr<TTransport> transport(new TBufferedTransport(socket));
    boost::shared_ptr<TProtocol> protocol(new TBinaryProtocol(transport));
    CalcClient client(protocol);

    try
    {
        transport->open();
        cout << "1 + 1 = " << client.add(1, 1) << endl;
        transport->close();
    }
    catch (TException& tx)
    {
        cout << "error: " << tx.what() << endl;
    }

    cout << "client end" << endl;
}
