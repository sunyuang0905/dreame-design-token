# DREAME Vue / Flutter 组件

同一套设计 Token 下的 Vue/uni-app 与 Flutter 原生基础组件，包含 H5 规格预览页。

## 本地预览

```bash
git clone https://github.com/sunyuang0905/dreame-design-token.git dreame-app
cd dreame-app
npm install
npm run dev:h5
```

预览页包含 Button、Input、Dialog、Step、Toast，支持 Vue / Flutter 用法切换和明暗模式切换。

## Flutter 集成

在 Flutter 项目的 `pubspec.yaml` 中引用仓库内 package：

```yaml
dependencies:
  dreame_flutter:
    git:
      url: https://github.com/sunyuang0905/dreame-design-token.git
      path: packages/dreame_flutter
```

```dart
import 'package:dreame_flutter/dreame_flutter.dart';

MaterialApp(
  theme: DreameTheme.light(),
  darkTheme: DreameTheme.dark(),
  home: DreameButton(text: '确定', onPressed: onOk),
);
```

Flutter 实现位于 `packages/dreame_flutter`，全部为 Dart 原生 Widget，不依赖 WebView。

## Vue / uni-app 集成

1. 将所需的 `src/components/dreame-*` 目录复制到项目的 `components/`
2. 引入 `src/common/dreame/css-vars.scss`
3. 按组件需要复制 `src/static/` 中的图标资源
4. 在 `pages.json` 配置 easycom：

```json
"^dreame-(.*)": "@/components/dreame-$1/dreame-$1.vue"
```

```vue
<dreame-button text="确定" @click="onOk" />
<dreame-button variant="secondary" text="取消" />
<dreame-input v-model="name" placeholder="请输入" />
<dreame-input-password v-model="password" :visible="visible" @toggle="visible = !visible" />
<dreame-dialog :show="open" title="弹窗标题" content="弹窗内容" @confirm="open = false" />
<dreame-toast :show="showToast" message="操作成功" />
<dreame-step-indicator :current="2" />
```

组件采用 Vue Options API，组件层不依赖 uView。

## 组件

| 标签 | 主要属性 |
|---|---|
| `dreame-button` | `variant`、`size`、`disabled`、`loading` |
| `dreame-input` | `value`、`placeholder`、`error`、`disabled` |
| `dreame-input-password` | `value`、`visible`、`error`、`disabled` |
| `dreame-input-otp` | `value`、`length`、`error`、`disabled` |
| `dreame-input-select` | `value`、`placeholder`、`error`、`disabled` |
| `dreame-dialog` | `show`、`placement`、`actions`、`buttonLayout` |
| `dreame-toast` | `show`、`message`、`position` |
| `dreame-step-indicator` | `steps`、`current` |

## Token

- `src/common/dreame/dreame-design-tokens.json`：Token 数据源
- `src/common/dreame/css-vars.scss`：运行时 CSS 变量
- `src/common/dreame/generate-css-vars.mjs`：生成脚本

```bash
npm run tokens:css
```

Token 引用层级为 `Component → Semantic → Primitive`。明暗模式通过 Semantic 层切换，组件变量名称保持一致。
