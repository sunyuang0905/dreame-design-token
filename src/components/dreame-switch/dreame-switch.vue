<template>
  <u-switch
    :modelValue="current"
    :disabled="disabled"
    :activeColor="T.on"
    :inactiveColor="T.off"
    :size="size"
    :asyncChange="asyncChange"
    @input="onChange"
    @update:modelValue="onChange"
    @change="onChange"
  />
</template>

<script>
const T = {
  on: 'var(--dreame-switch-track-on)',
  off: 'var(--dreame-switch-track-off)'
}

export default {
  name: 'DreameSwitch',
  props: {
    modelValue: { type: Boolean, default: undefined },
    value: { type: Boolean, default: undefined },
    disabled: Boolean,
    size: { type: [String, Number], default: 25 },
    asyncChange: Boolean
  },
  data() {
    return { T }
  },
  computed: {
    current() {
      return this.modelValue !== undefined ? this.modelValue : !!this.value
    }
  },
  methods: {
    onChange(val) {
      this.$emit('update:modelValue', val)
      this.$emit('input', val)
      this.$emit('change', val)
    }
  }
}
</script>
