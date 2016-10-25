#include <iostream>
#include <functional>
#include <boost/asio.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>

using namespace std;
using namespace std::placeholders;

void handler(const boost::system::error_code& err, boost::asio::deadline_timer* ptimr, int* cnt)
{
    if (err)
        cout << err.message() << endl;
    cout << "count: " << *cnt << endl;
    --(*cnt);
    if (*cnt > 0)
        ptimr->async_wait(bind(handler, _1, ptimr, cnt));
}

int main()
{
    int cnt = 5;

    boost::asio::io_service ios;
    boost::asio::deadline_timer timr(ios, boost::posix_time::milliseconds(100));

    timr.async_wait(bind(handler, _1, &timr, &cnt));

    ios.run();

    return 0;
};

