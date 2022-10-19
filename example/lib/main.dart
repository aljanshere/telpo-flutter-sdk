import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:telpo_flutter_sdk/telpo_flutter_sdk.dart';

const telpoColor = Color(0xff005AFF);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _connected = false;
  String _telpoStatus = 'Not initialized';
  bool _isLoading = false;

  final _telpoFlutterChannel = TelpoFlutterChannel();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _connect() async {
    // Platform calls are catched on plugin-side. No need to use try-catch here,
    // as connect() method returns non-nullable boolean.

    final bool connected = await _telpoFlutterChannel.connect();

    setState(() {
      _connected = connected;

      _telpoStatus = _connected ? 'Connected' : 'Telpo not supported';
    });
  }

  Future<void> _checkStatus() async {
    String telpoStatus;

    final TelpoStatus status = await _telpoFlutterChannel.checkStatus();
    telpoStatus = status.name;

    setState(() => _telpoStatus = telpoStatus);
  }

  Future<void> _printData() async {
    setState(() => _isLoading = true);

    // Creating an [TelpoPrintSheet] instance.
    final sheet = TelpoPrintSheet();

    // Creating a text element
    final textData = PrintData.text(
      'TelpoFlutterSdk',
      alignment: PrintAlignment.center,
      fontSize: PrintedFontSize.size34,
    );

    // Creating 8-line empty space element.
    final spacing = PrintData.space(line: 8);

    // Inserting previously created text element to the sheet.
    sheet.addElement(textData);

    // Inserting previously created spacing element to the sheet.
    sheet.addElement(spacing);

    final PrintResult result = await _telpoFlutterChannel.print(sheet);

    setState(() {
      _telpoStatus = result.name;
      _isLoading = false;
    });
  }

  @override
  void setState(VoidCallback fn) {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    // Disconnecting from Telpo.
    _telpoFlutterChannel.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: const Color(0xffFF8D49),
        title: const Text('Telpo plugin example'),
        actions: [
          if (_isLoading)
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 16.0),
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Telpo status: $_telpoStatus',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 32.0),
            CupertinoButton(
              color: telpoColor,
              onPressed: _isLoading ? null : _connect,
              child: const Text('Initialize'),
            ),
            if (_connected) ...[
              const SizedBox(height: 24.0),
              CupertinoButton(
                color: telpoColor,
                onPressed: _isLoading ? null : _checkStatus,
                child: const Text(
                  'Check status',
                ),
              ),
              if ([PrintResult.success.name, TelpoStatus.ok.name].contains(_telpoStatus)) ...[
                const SizedBox(height: 24.0),
                CupertinoButton(
                  color: telpoColor,
                  onPressed: _isLoading ? null : _printData,
                  child: Text(
                    _isLoading ? 'Printing' : 'Print',
                  ),
                ),
              ]
            ],
          ],
        ),
      ),
    );
  }
}
