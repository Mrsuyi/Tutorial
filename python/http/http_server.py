#!/usr/bin/env python
# -*- coding: utf-8 -*-

import http.server

class MyHttpServer(http.server.BaseHTTPRequestHandler):
    def do_GET(s):
        s.send_response(200)
        s.send_header('Content-type', 'text/html')
        s.end_headers()
        s.wfile.write("<html><body><h1>fuck you</h1></body></html>".encode('utf-8'))

httpd = http.server.HTTPServer(('localhost', 8000), MyHttpServer)

try:
    httpd.serve_forever()
except KeyboardInterrupt:
    pass

httpd.server_close()
