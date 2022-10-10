import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _telpoStatus = 'Unknown';
  bool _isLoading = false;

  final TelpoFlutterChannel _telpoSdkFlutterPlugin = TelpoFlutterChannel();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String telpoStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      final status = await _telpoSdkFlutterPlugin.checkStatus();

      telpoStatus = status.name;
    } on PlatformException {
      telpoStatus = 'Failed to get status.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _telpoStatus = telpoStatus;
    });
  }

  Future<void> printData() async {
    setState(() {
      _isLoading = true;
    });

    final printableData = <PrintData>[];

    const data = PrintText(
      text: 'TelpoFlutterPlugin',
      alignment: PrintAlignment.center,
      fontSize: PrintedFontSize.size34,
    );

    printableData.add(data);
    printableData.add(const WalkPaper(step: 8));

    try {
      await _telpoSdkFlutterPlugin.print(printableData);
    } catch (e) {
      log(e.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Telpo Status: $_telpoStatus'),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        await printData();
                      },
                child: Text(_isLoading ? 'Printing' : 'Print'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
