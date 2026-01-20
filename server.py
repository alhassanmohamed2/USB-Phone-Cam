import os
import tornado.ioloop
import tornado.web
import tornado.websocket
import json

PORT = 3000

class SignalingHandler(tornado.websocket.WebSocketHandler):
    clients = set()

    def check_origin(self, origin):
        return True

    def open(self):
        print("WebSocket opened")
        SignalingHandler.clients.add(self)

    def on_message(self, message):
        # Broadcast message to all OTHER clients
        try:
            is_binary = isinstance(message, bytes)
            dead_clients = set()
            
            for client in SignalingHandler.clients:
                if client != self:
                    try:
                        client.write_message(message, binary=is_binary)
                    except tornado.websocket.WebSocketClosedError:
                        dead_clients.add(client)
                    except Exception as e:
                        print(f"Write error: {e}")
                        dead_clients.add(client)
            
            # Clean up dead clients
            for dead in dead_clients:
                if dead in SignalingHandler.clients:
                    SignalingHandler.clients.remove(dead)
                    
        except Exception as e:
            print(f"Error handling message: {e}")

    def on_close(self):
        print("WebSocket closed")
        if self in SignalingHandler.clients:
            SignalingHandler.clients.remove(self)

class NoCacheStaticFileHandler(tornado.web.StaticFileHandler):
    def set_extra_headers(self, path):
        self.set_header('Cache-Control', 'no-store, no-cache, must-revalidate, max-age=0')

def make_app():
    return tornado.web.Application([
        (r"/ws", SignalingHandler),
        (r"/(.*)", NoCacheStaticFileHandler, {
            "path": os.path.join(os.path.dirname(__file__), "public"),
            "default_filename": "index.html"
        }),
    ])

if __name__ == "__main__":
    app = make_app()
    app.listen(PORT)
    print(f"Server starting on http://localhost:{PORT}")
    try:
        tornado.ioloop.IOLoop.current().start()
    except KeyboardInterrupt:
        print("\nStopping server...")
