import DreameButton from './components/dreame-button/dreame-button.vue'
import DreameDialog from './components/dreame-dialog/dreame-dialog.vue'
import DreameInput from './components/dreame-input/dreame-input.vue'
import DreameInputOtp from './components/dreame-input-otp/dreame-input-otp.vue'
import DreameInputPassword from './components/dreame-input-password/dreame-input-password.vue'
import DreameInputSelect from './components/dreame-input-select/dreame-input-select.vue'
import DreameStepIndicator from './components/dreame-step-indicator/dreame-step-indicator.vue'
import DreameSwitch from './components/dreame-switch/dreame-switch.vue'
import DreameToast from './components/dreame-toast/dreame-toast.vue'

const components = [
  DreameButton,
  DreameDialog,
  DreameInput,
  DreameInputOtp,
  DreameInputPassword,
  DreameInputSelect,
  DreameStepIndicator,
  DreameSwitch,
  DreameToast,
]

export {
  DreameButton,
  DreameDialog,
  DreameInput,
  DreameInputOtp,
  DreameInputPassword,
  DreameInputSelect,
  DreameStepIndicator,
  DreameSwitch,
  DreameToast,
}

export default {
  install(app) {
    components.forEach((component) => app.component(component.name, component))
  },
}
