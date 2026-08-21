<template>
    <view class="dreame-input" :class="rootClass">
        <input
            class="dreame-input__field"
            :value="current"
            :placeholder="placeholder"
            :disabled="isDisabled"
            :maxlength="maxlength"
            :password="false"
            placeholder-class="dreame-input__ph"
            @input="onInput"
            @focus="onFocus"
            @blur="onBlur"
            @confirm="$emit('confirm', $event)"
        />
    </view>
</template>

<script>
/**
 * dreame-input
 * state = default | focus | filled | error | disabled
 * 填充式无描边；focus / error 走 input token
 */
export default {
    name: 'DreameInput',
    props: {
        value: {
            type: [String, Number],
            default: undefined,
        },
        modelValue: {
            type: [String, Number],
            default: undefined,
        },
        placeholder: {
            type: String,
            default: '请输入',
        },
        disabled: {
            type: Boolean,
            default: false,
        },
        error: {
            type: Boolean,
            default: false,
        },
        maxlength: {
            type: [String, Number],
            default: 140,
        },
        previewState: {
            type: String,
            default: '',
        },
    },
    data() {
        return {
            focused: false,
        };
    },
    computed: {
        current() {
            if (this.modelValue !== undefined) return this.modelValue;
            if (this.value !== undefined) return this.value;
            return '';
        },
        visualState() {
            if (this.previewState) return this.previewState;
            if (this.disabled) return 'disabled';
            if (this.error) return 'error';
            if (this.focused) return 'focus';
            if (String(this.current).length) return 'filled';
            return 'default';
        },
        isDisabled() {
            return this.disabled || this.previewState === 'disabled';
        },
        rootClass() {
            return ['is-' + this.visualState];
        },
    },
    methods: {
        readVal(e) {
            if (typeof e === 'string' || typeof e === 'number') return String(e);
            if (e && e.detail && e.detail.value !== undefined) return e.detail.value;
            if (e && e.target) return e.target.value;
            return '';
        },
        emitVal(val) {
            this.$emit('input', val);
            this.$emit('update:modelValue', val);
        },
        onInput(e) {
            if (this.previewState) return;
            this.emitVal(this.readVal(e));
        },
        onFocus(e) {
            if (this.previewState || this.isDisabled) return;
            this.focused = true;
            this.$emit('focus', e);
        },
        onBlur(e) {
            this.focused = false;
            this.$emit('blur', e);
        },
    },
};
</script>

<style lang="scss" scoped>
.dreame-input {
    box-sizing: border-box;
    display: flex;
    flex-direction: row;
    align-items: center;
    width: 354px;
    max-width: 100%;
    height: var(--dreame-space-48);
    padding: 0 var(--dreame-space-12);
    border-radius: var(--dreame-radius-8);
    border-width: var(--dreame-space-2);
    border-style: solid;
    border-color: transparent;
    background: var(--dreame-input-bg-default);

    &__field {
        flex: 1;
        min-width: 0;
        height: calc(var(--dreame-space-16) + var(--dreame-space-4));
        padding: 0;
        margin: 0;
        border: none;
        outline: none;
        background: transparent;
        font-family: var(--dreame-font-family-system), -apple-system, sans-serif;
        font-size: var(--dreame-font-size-16);
        font-weight: var(--dreame-font-weight-regular);
        line-height: calc(var(--dreame-space-16) + var(--dreame-space-4));
        color: var(--dreame-input-text-value);
    }

    &__ph {
        color: var(--dreame-input-text-placeholder);
        font-size: var(--dreame-font-size-16);
    }

    &.is-default .dreame-input__field {
        color: var(--dreame-input-text-placeholder);
    }

    &.is-filled .dreame-input__field {
        color: var(--dreame-input-text-value);
    }

    &.is-focus {
        border-color: var(--dreame-input-border-focus);
    }

    &.is-error {
        border-color: var(--dreame-input-border-error);
    }

    &.is-disabled {
        background: var(--dreame-input-bg-disabled);

        .dreame-input__field {
            color: var(--dreame-text-disabled);
        }
    }
}
</style>
