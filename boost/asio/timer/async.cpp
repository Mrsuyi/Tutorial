#include <iostream>
#include <thread>
#include <boost/asio.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>

using namespace std;

void handler(const boost::system::error_code& err)
{
    if (err)
        cout << err.message() << endl;
    cout << "end\n";
}

int main()
{
    boost::asio::io_service ios;
    boost::asio::deadline_timer timr(ios, boost::posix_time::seconds(1));

    timr.async_wait(handler);

    //this_thread::sleep_for(std::chrono::milliseconds(3000));

    ios.run();

    return 0;
};

