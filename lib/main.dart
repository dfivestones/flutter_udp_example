import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Lighting controller'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _send() {
    setState(() {
      RawDatagramSocket.bind(InternetAddress.anyIPv4, 4444)
          .then((RawDatagramSocket socket) {
        print('Sending from ${socket.address.address}:${socket.port}');
        /*
        socket.listen((RawSocketEvent event) {
          Datagram? d = socket.receive();
          if (d == null) return;
          String message = String.fromCharCodes(d.data).trim();
          print('datagram from ${d.address.address} : ${d.port} : $message');
        });*/

        int port = 4444;
        socket.send('Do you get my message..\n copy?'.codeUnits,
            InternetAddress("192.168.25.16"), port);
      });
    });

    // RawDatagramSocket.bind(InternetAddress.anyIPv4, 4444)
    //     .then((RawDatagramSocket socket) {
    //   print('UDP Echo ready to receive');
    //   print('${socket.address.address}:${socket.port}');
    //   socket.listen((RawSocketEvent e) {
    //     Datagram? d = socket.receive();
    //     if (d == null) return;

    //     String message = new String.fromCharCodes(d.data);
    //     print(
    //         'Datagram from ${d.address.address}:${d.port}: ${message.trim()}');

    //     socket.send(message.codeUnits, d.address, d.port);
    //   });
    // });
  }

  void _receive() {
    setState(() {
      RawDatagramSocket.bind(InternetAddress.anyIPv4, 4444)
          .then((RawDatagramSocket socket) {
        print('datagram socket ready to receive');
        print('Sending from ${socket.address.address}:${socket.port}');
        // int port = 4000;

        socket.listen((RawSocketEvent event) {
          Datagram? d = socket.receive();
          if (d == null) return;
          String message = String.fromCharCodes(d.data).trim();
          print('datagram from ${d.address.address} : ${d.port} : $message');
        });
      });
    });

    //   RawDatagramSocket.bind(InternetAddress.anyIPv4, 4444)
    //       .then((RawDatagramSocket socket) {
    //     print('UDP Echo ready to receive');
    //     print('${socket.address.address}:${socket.port}');
    //     socket.listen((RawSocketEvent e) {
    //       Datagram? d = socket.receive();
    //       if (d == null) return;

    //       String message = new String.fromCharCodes(d.data);
    //       print(
    //           'Datagram from ${d.address.address}:${d.port}: ${message.trim()}');

    //       socket.send('what do you want'.codeUnits, d.address, d.port);
    //     });
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: Text(
                "sender",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: _send,
            ),
            Padding(
              padding: new EdgeInsets.fromLTRB(10, 100, 10, 10),
            ),
            FlatButton(
              color: Colors.red,
              highlightColor: Colors.red[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: Text(
                "receiver",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: _receive,
            ),
          ],
        ),
      ),
    );
  }
}
