# window


## Features

1. [x] Custom Native App Bar
2. [x] Rounded window
3. [x] easy to use


```bash
dart pub add window_app
```

init
```bash
dart run window_app init
```

import package
```dart
import "package:window_app/window_app.dart" as window_package;
```


```dart

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  window_package.WindowApp.init(initialSize: const Size(1280, 720), minSize: const Size(1280, 720));

  // ---

  // runApp(
  //  --
  // );

  // ---
}
```

