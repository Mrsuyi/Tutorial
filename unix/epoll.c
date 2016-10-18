#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/epoll.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

const int EPOLL_CAPACITY = 100;
const int BUF_LEN = 256;
const int SOCKET_CAPACITY = 100;

void
error(const char *msg)
{
    perror(msg);
    exit(1);
}

int
listen_on_port(int port)
{
    // create socket-fd
    int sock_fd;
    sock_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (sock_fd < 0) error("ERROR opening socket\n");

    // config listening-address
    struct sockaddr_in serv_addr;
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(port);

    // bind socket-fd to socket-addr
    // after this, others cannot use the same port
    if (bind(sock_fd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
        error("ERROR on binding\n");

    // begin listening on socket
    // after this, clients can connect to this socket
    if (listen(sock_fd, SOCKET_CAPACITY) != 0)
        error("ERROR on listening\n");

    return sock_fd;
}

int
epoll_set(int epoll_fd, int oper, int target_fd, int events)
{
    struct epoll_event event;
    event.events = events;
    event.data.fd = target_fd;
    return epoll_ctl(epoll_fd, oper, target_fd, &event);
}

void
client_accept(int epoll_fd, int s_sock_fd)
{
    struct sockaddr_in c_addr;
    socklen_t          c_addr_len;
    int                c_sock_fd;

    c_addr_len = sizeof(c_addr);
    c_sock_fd = accept(s_sock_fd, (struct sockaddr *)&c_addr, &c_addr_len);
    if (c_sock_fd < 0) error("ERROR on accept\n");

    char* client_addr = inet_ntoa(c_addr.sin_addr);
    printf("new connection from: %s:%u\n", client_addr, c_addr.sin_port);

    epoll_set(epoll_fd, EPOLL_CTL_ADD, c_sock_fd, EPOLLIN);
}

void
client_read(int epoll_fd, int fd)
{
    char buf[BUF_LEN];

    memset(buf, 0, sizeof(buf));
    int cnt = read(fd, buf, BUF_LEN);

    if (cnt < 0)
    {
        printf("read error\n");
        close(fd);
        epoll_set(epoll_fd, EPOLL_CTL_DEL, fd, EPOLLIN);
    }
    else if (cnt == 0)
    {
        printf("connection close\n");
        close(fd);
        epoll_set(epoll_fd, EPOLL_CTL_DEL, fd, EPOLLIN);
    }
    else
    {
        printf("received message: %s\n", buf);
        epoll_set(epoll_fd, EPOLL_CTL_MOD, fd, EPOLLOUT);
    }
}

void
client_write(int epoll_fd, int fd)
{
    char buf[] = "This is a return message from server :D\n";
    int cnt = write(fd, buf, sizeof(buf));

    if (cnt < 0)
    {
        printf("write error\n");
        close(fd);
        epoll_set(epoll_fd, EPOLL_CTL_DEL, fd, EPOLLOUT);
    }
    else
    {
        printf("write success\n");
        epoll_set(epoll_fd, EPOLL_CTL_MOD, fd, EPOLLIN);
    }
}

int
main(int argc, char *argv[])
{
    if (argc < 2)
    {
        fprintf(stderr, "ERROR, no port provided\n");
        exit(1);
    }

    int s_sock_fd = listen_on_port(atoi(argv[1]));

    // init epoll
    struct epoll_event events[EPOLL_CAPACITY];
    int epoll_fd = epoll_create(EPOLL_CAPACITY);

    if (epoll_set(epoll_fd, EPOLL_CTL_ADD, s_sock_fd, EPOLLIN) != 0)
        error("ERROR, add listening-socket-fd to epoll failed\n");

    printf("begin listening\n");

    // begin events loop
    for (;;)
    {
        int events_size = epoll_wait(epoll_fd, events, EPOLL_CAPACITY, -1);

        for (int i = 0; i < events_size; ++i)
        {
            int fd = events[i].data.fd;

            if ((fd == s_sock_fd) && (events[i].events & EPOLLIN))
            {
                client_accept(epoll_fd, s_sock_fd);
            }
            else if (events[i].events & EPOLLIN)
            {
                client_read(epoll_fd, events[i].data.fd);
            }
            else if (events[i].events & EPOLLOUT)
            {
                client_write(epoll_fd, events[i].data.fd);
            }
        }
    }

    close(s_sock_fd);
    close(epoll_fd);
    return 0;
}
