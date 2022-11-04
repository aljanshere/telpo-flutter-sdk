# telpo_flutter_sdk
[![Pub Version](https://img.shields.io/pub/v/telpo_flutter_sdk?style=flat-square)](https://pub.dev/packages/telpo_flutter_sdk)

A Flutter plugin for handling connection and communication with Telpo thermal printer devices.

<img  src="https://raw.githubusercontent.com/AL-ventures/telpo-flutter-sdk/master/.docs/cover.png"  alt="cover" />


## 💡 Motivation

While developing <a href="https://mashin.al">MASHINPAY</a> payment solution we've purchased Telpo thermal printers ("M1"s specifically) for printing invoice files after users' successful transaction. The Telpo devices come with a native SDK and documentation for it. Since there wasn't an official plugin for Flutter, we had to customize the plugin by ourselves. We've added so many useful methods for better handling exceptions, customizable print layout and etc.

## ⚙️ Android setup
1. Add ```url "https://jitpack.io"``` for `maven` to project level `build.gradle` file (`android/build.gradle`).

```gradle
allprojects {
    repositories {
        ...
        maven { url "https://jitpack.io" }
        ...
    }
}
```

2. Set the `minSdkVersion` as 19 in application level `build.gradle` file (`android/app/build.gradle`).

```gradle
android {
    defaultConfig {
        ...
        minSdkVersion 19
        ...
    }
}
```
 


## 🕹️ Usage

### Initialization

To get started, create an instance of `TelpoFlutterChannel`:

```dart
final _telpoFlutterChannel = TelpoFlutterChannel();
```


Connecting with Telpo:
```dart
final bool connected = await _telpoFlutterChannel.connect();
// Result: true, false.
```

Checking Telpo's status:
```dart
final TelpoStatus status = await _telpoFlutterChannel.checkStatus();
// Result: ok, noPaper, overHeat, cacheIsFull, unknown.
```

Checking connection status with Telpo:
```dart
final bool status = await _telpoFlutterChannel.isConnected();
// Result: true, false.
```

Printing a sheet:

```dart
// Creating an empty sheet
final sheet = TelpoPrintSheet();

// Creating a text element
const textData = PrintData.text(
  'TelpoFlutterSdk',
  alignment: PrintAlignment.center,
  fontSize: PrintedFontSize.size34,
);

// Creating 8-line empty space
const spacing = PrintData.space(step: 8);

// Inserting previously created text element to the sheet.
sheet.addElement(textData);

// Inserting previously created spacing element to the sheet.
sheet.addElement(spacing);

final PrintResult result = await _telpoFlutterChannel.print(sheet);
// Result: success, noPaper, lowBattery, overHeat, dataCanNotBeTransmitted, other.
```

## 📝 Roadmap

✅ Well-written documentation 🤓  
✅ Document the platform-specific configurations.  
✅ Add explanations for `Enum` values of `PrintResult` and `TelpoStatus`.  
⏳ Print image file.  
⏳ Toggle printing event via NFC. 🤩  
⏳ Toggle printing event via BlueTooth, may be?  
⏳ Checking if Telpo is available on the device?  


## 🤓 Contributors

<a  href="https://github.com/al-ventures/telpo-flutter-sdk/graphs/contributors"> <img  src="https://github.com/kamranbekirovyz.png" height="75"> </a><a  href="https://github.com/al-ventures/telpo-flutter-sdk/graphs/contributors"> <img  src="https://github.com/aljanshere.png" height="75"> </a>


## 🙏 Credits

While we were trying to understand and port the Telpo device to the Flutter framework we got very inspiring code samples and examples from [Efikas](https://github.com/efikas)'s plugin ([flutter_telpo](https://pub.dev/packages/flutter_telpo)) for Flutter which can be considered as a basic version of our plugin and our plugin can be considered as more customized of his since both of us used the same native implementation of the Telpo's Android SDK which comes together with the Telpo device.

## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on GitHub and we'll look into it. Pull requests are welcome.

## 📃 License

[MIT License](https://github.com/AL-ventures/telpo-flutter-sdk/blob/master/LICENSE)
