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

## 包结构

```text
packages/
├── dreame-vue/       # 一个 Vue/uni-app 包，包含全部 Vue 组件
└── dreame_flutter/   # 一个 Flutter 包，包含全部 Flutter 组件
```

组件不会拆成多个小包。业务项目在对应技术端只引入一个包，后续通过 package version 统一升级。

## Vue / uni-app 集成

将 `packages/dreame-vue` 发布至团队 npm registry 后安装：

```bash
npm install @dreame/design-system-vue
```

```js
import DreameDesignSystem from '@dreame/design-system-vue'
import '@dreame/design-system-vue/styles'

app.use(DreameDesignSystem)
```

也支持直接导入单个组件：

```js
import { DreameButton, DreameInput } from '@dreame/design-system-vue'
```

如果使用 uni-app easycom，可配置包内组件路径：

```json
"^dreame-(.*)": "@dreame/design-system-vue/components/dreame-$1"
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
- `docs/shadow-primitives.md`：Shadow Primitive 参数与 Effect Style 对照

```bash
npm run tokens
```

Token 引用层级为 `Component → Semantic → Primitive`。明暗模式通过 Semantic 层切换，组件变量名称保持一致。
