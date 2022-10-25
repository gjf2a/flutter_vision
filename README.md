# flutter_vision

This library is designed to enable Computer Vision in a Flutter application by means of a Rust
back-end native library.

## Features

This package is, for now, under heavy development and highly unstable. 

* Convert Flutter camera images to RGB or grayscale.
* Perform optic flow calculations to estimate trajectory.

## Getting started

* This package assumes use of the [camera](https://pub.dev/packages/camera) plugin.
* `import 'package:flutter_vision/flutter_vision.dart';`

### `pubspec.yaml`
```
dependencies:
  flutter_vision:
    git: https://github.com/gjf2a/flutter_vision
```

### Using with Android

* Copy the [Android Native Libraries](https://github.com/gjf2a/flutter_vision/tree/main/android/app/src/main/jniLibs) to `android/app/src/main/jniLibs`.
* So far, I have built `arm64-v8a` and `armeabi-v7a`. I will build others as the need arises.
* The ultimate goal is to find a way to package these automatically, but I haven't figured out how to do that as of yet.

### Using with iOS

So far, I have not yet compiled the Rust code for iOS, so this is a work-in-progress.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
