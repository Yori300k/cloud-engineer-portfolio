from http.server import HTTPServer, BaseHTTPRequestHandler

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b"<h1>Cloud Portfolio - Project 06</h1><p>Running inside a Docker container on AWS</p>")

    def log_message(self, format, *args):
        pass

httpd = HTTPServer(('0.0.0.0', 8080), Handler)
print("Server running on port 8080...")
httpd.serve_forever()
