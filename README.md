# NarouReader

NarouReader is an application designed to read Narou novels using the Narou API. this project serves as a personal learing experience and is intemded for self-satisfaction. While there is a future goal to release it on the App Store, this may take some time duee to the cost of a developer account. Note that the app has not been tested on Android devisces, so its fuctioality on such devices is not graranteed. 

## Features

- **Retrieve Novel Details**: Get detailed information about novels, such as titles and author names, using the Narou API.
- **Bookmark Functionality**: Save your favorite novels for easy access later.
- **Planned Features**: For upcoming features, please check the issues section.

## Getting Started

This project is a starting point for a Flutter application.

### Resources to Get You Started

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- For help with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Directory Structure

```
lib/
├── main.dart
├── database/
│   └── post.dart
├── services/
│   └── api_service.dart
└── screens/
    ├── home_screen.dart
    ├── detailPage.dart
    ├── savedListPage.dart
    └── savedlistscreen_detailPage.dart
```

## Bug Reports and Requests

If you encounter any bugs or have requests, please create an issue in the repository. 

## Notes

- This application uses the Narou API.
- Direct linking to the site from NarouReader is not implemented.
- Verification on Android devices is not guaranteed.

## Public
- http: ^1.2.1
- flutter_riverpod: ^2.5.1
- sqflite
- flutter_slidable: ^3.1.1
- url_Lancher: ^6.3.1