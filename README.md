# OBD JS SDK Demo for Flutter

Using Flutter to develop a demo app that demonstrates how to use OBD JS SDK.

## Getting Started

Currently there are some ways to do it.

A few resources are below:

### Flutter WebView

- [Flutter WebView与JS交互简易指南](https://juejin.im/post/5ca1da31e51d4509ea3d0540)

### Dart.js

Dart.js is a built-in library that can interop with JavaScript. But only supported for Flutter web app.

- [How to use JS with Flutter Web](https://fireship.io/snippets/using-js-with-flutter-web/)
- [dart:js library](https://api.dart.dev/stable/2.8.4/dart-js/dart-js-library.html)

### package:js

Use this package when you want to call JavaScript APIs from Dart code, or vice versa.
But the test failed because the @JS() annotation could not be recognized.

- [js 0.6.2](https://pub.dev/packages/js)

### other flutter js packages

Other flutter js packages on pub.dev website.

- [other flutter js packages](https://pub.dev/packages?q=js)