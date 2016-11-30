#!/usr/bin/env node

var http = require('http');

http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('shit');
}).listen(9615);
