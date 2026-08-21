# @dreame/design-system-vue

DREAME Vue 3 / uni-app 组件包。一个包内包含全部已交付组件，业务项目只需引入一次。

```js
import { createSSRApp } from 'vue'
import DreameDesignSystem from '@dreame/design-system-vue'
import '@dreame/design-system-vue/styles'

const app = createSSRApp(App)
app.use(DreameDesignSystem)
```

也支持按需引入：

```js
import { DreameButton, DreameInput } from '@dreame/design-system-vue'
```

组件更新通过 package version 统一交付，不需要逐个复制组件文件。
