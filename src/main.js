import { createSSRApp } from 'vue'
import uviewPlus from 'uview-plus'
import App from './App.vue'
import DreameDesignSystem from '../packages/dreame-vue/index.js'

export function createApp() {
  const app = createSSRApp(App)
  app.use(uviewPlus)
  app.use(DreameDesignSystem)
  return { app }
}
