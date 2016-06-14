#include <iostream>

#include <thrift/protocol/TBinaryProtocol.h>
#include <thrift/transport/TSocket.h>
#include <thrift/transport/TTransportUtils.h>

#include "gen-cpp/Calc.h"
#include "gen-cpp/Calc_types.h"

using namespace std;
using namespace apache::thrift;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;

using namespace calc;

int main(int argc, char* argv[])
{
    cout << "client run on " << argv[1] << endl;
    
    boost::shared_ptr<TTransport> socket(new TSocket("localhost", atoi(argv[1])));
    boost::shared_ptr<TTransport> transport(new TBufferedTransport(socket));
    boost::shared_ptr<TProtocol> protocol(new TBinaryProtocol(transport));
    CalcClient client(protocol);

    try
    {
        transport->open();

        try
        {
            Result res;

            client.calculate(res, Operation::ADD, 1, 1);
            cout << "1 + 1 = " << res.value << endl;
            
            client.calculate(res, Operation::DEC, 5, 3);
            cout << "5 - 3 = " << res.value << endl;

            client.calculate(res, Operation::MUL, 2, 2);
            cout << "2 * 2 = " << res.value << endl;

            client.calculate(res, Operation::DIV, 4, 0);
            cout << "4 * 0 = " << res.value << endl;
        }
        catch (CalcError err)
        {
            cout << err.what << endl;
        }

        transport->close();
    }
    catch (TException& tx)
    {
        cout << "error: " << tx.what() << endl;
    }

    cout << "client end" << endl;
}
