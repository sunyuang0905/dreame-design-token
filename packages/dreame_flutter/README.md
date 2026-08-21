# dreame_flutter

DREAME 设计系统的 Flutter 原生组件包，与仓库内 Vue/uni-app 组件共用同一份 Design Token。

```dart
import 'package:dreame_flutter/dreame_flutter.dart';

MaterialApp(
  theme: DreameTheme.light(),
  darkTheme: DreameTheme.dark(),
  home: DreameButton(text: '确定', onPressed: () {}),
);
```

已提供 Button、Text/Password/OTP/Select Input、Dialog/Bottom Sheet、Step Indicator 与 Toast。

Token 更新后，在仓库根目录运行：

```bash
npm run tokens
```
