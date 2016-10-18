#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

void
error(const char *msg)
{
    perror(msg);
    exit(1);
}

int
main(int argc, char *argv[])
{
    int sockfd, newsockfd, portno;
    socklen_t clilen;
    char buffer[256];
    struct sockaddr_in serv_addr, cli_addr;
    int n;

    if (argc < 2) {
        fprintf(stderr, "ERROR, no port provided\n");
        exit(1);
    }

    // create socket file-descriptor
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) error("ERROR opening socket\n");

    // config socket address
    bzero((char *)&serv_addr, sizeof(serv_addr));
    portno = atoi(argv[1]);
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(portno);

    // bind socket-fd to socket-addr
    // the port will be occupied
    if (bind(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
        error("ERROR on binding\n");

    // listen on socket, allow clients to connect
    listen(sockfd, 5);

    for (;;) {
        // try get a client-connenction
        // block if no client connects
        clilen = sizeof(cli_addr);
        newsockfd = accept(sockfd, (struct sockaddr *)&cli_addr, &clilen);
        if (newsockfd < 0) error("ERROR on accept\n");
        char *client_addr = inet_ntoa(cli_addr.sin_addr);
        printf("new connection from: %s:%u\n", client_addr, cli_addr.sin_port);

        // read
        bzero(buffer, 256);
        n = read(newsockfd, buffer, 255);
        if (n < 0) error("ERROR reading from socket\n");
        printf("Here is the message: %s\n", buffer);

        // write
        n = write(newsockfd, "I got your message\n", 18);
        if (n < 0) error("ERROR writing to socket\n");

        // close connection
        close(newsockfd);
    }

    close(sockfd);
    return 0;
}
