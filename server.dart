import 'dart:io';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

void main() async {
  final server = await HttpServer.bind('localhost', 8080);
  print('Listening on port 8080...');

  server.listen((HttpRequest request) {
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      WebSocketTransformer.upgrade(request).then((WebSocket webSocket) {
        print('WebSocket connected');
        WebSocketChannel channel = IOWebSocketChannel(webSocket);

        channel.stream.listen((message) {
          print('Received message: $message');
        });
      });
    }
  });
}
