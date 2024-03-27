# SelectTextField

SelectTextField is a Flutter package that provides a customizable text field widget with a dropdown icon. It allows users to select options from a modal bottom sheet, providing a convenient and intuitive user interface for selecting values.

## UI
![Screen shoot](https://github.com/aro-wolo/select_text_field/assets/109182707/6d9efef8-5490-4ba9-b885-2e3275a2c66c)


## Features

- Integration of text field and dropdown functionality into a single widget.
- Customizable appearance and behavior to fit various use cases.
- Easy integration with existing Flutter projects.
- Provides a modal bottom sheet for selecting options, ensuring a consistent user experience across platforms.

## Installation

To use SelectTextField in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  select_text_field: ^0.0.2  # Replace with the latest version

``` 
Then, run `flutter pub get` to install the package.

## Usage

```dart
import 'package:select_text_field/select_text_field.dart';
```
You can then use the SelectTextField widget in your Flutter app:

```dart
SelectTextField(
  options: ['Option 1', 'Option 2', 'Option 3'],
  label: 'Select an option',
  controller: TextEditingController(),
  onChanged: (value) {
    // Handle selected value
  },
),
```  