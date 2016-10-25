#include <iostream>
#include <boost/asio.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>

using namespace std;

int main()
{
    boost::asio::io_service ios;
    boost::asio::deadline_timer timr(ios, boost::posix_time::seconds(3));

    timr.wait();

    cout << "end\n";

    return 0;
};

