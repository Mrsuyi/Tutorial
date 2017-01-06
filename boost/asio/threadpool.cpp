#include <boost/asio/io_service.hpp>
#include <boost/bind.hpp>
#include <boost/thread/thread.hpp>
#include <iostream>

using namespace std;

int
main()
{
    boost::asio::io_service ios;
    boost::thread_group threadpool;

    boost::asio::io_service::work work(ios);

    threadpool.create_thread(boost::bind(&boost::asio::io_service::run, &ios));
    threadpool.create_thread(boost::bind(&boost::asio::io_service::run, &ios));
    threadpool.create_thread(boost::bind(&boost::asio::io_service::run, &ios));

    for (int i = 0; i < 10000; ++i) ios.post([]() { cout << "shit" << endl; });

    ios.stop();

    threadpool.join_all();

    return 0;
}
