<template>
    <view class="dreame-otp" :class="rootClass" @click="onWrapClick">
        <input
            class="dreame-otp__hidden"
            :value="current"
            :disabled="isDisabled"
            :maxlength="6"
            type="number"
            @input="onInput"
            @focus="onFocus"
            @blur="onBlur"
        />
        <view v-for="i in 6" :key="i" class="dreame-otp__cell">
            <text class="dreame-otp__digit">{{ digits[i - 1] }}</text>
            <view class="dreame-otp__line" />
        </view>
    </view>
</template>

<script>
/**
 * dreame-input-otp
 * 默认 6 位，支持错误态与禁用态。
 */
export default {
    name: 'DreameInputOtp',
    props: {
        value: { type: [String, Number], default: undefined },
        modelValue: { type: [String, Number], default: undefined },
        disabled: { type: Boolean, default: false },
        error: { type: Boolean, default: false },
        previewState: { type: String, default: '' },
    },
    data() {
        return { focused: false };
    },
    computed: {
        current() {
            let raw = '';
            if (this.modelValue !== undefined) raw = String(this.modelValue);
            else if (this.value !== undefined) raw = String(this.value);
            return raw.replace(/\D/g, '').slice(0, 6);
        },
        digits() {
            const chars = this.current.split('');
            const out = [];
            for (let i = 0; i < 6; i++) out.push(chars[i] || '');
            return out;
        },
        visualState() {
            if (this.previewState) return this.previewState;
            if (this.disabled) return 'disabled';
            if (this.error) return 'error';
            if (this.current.length) return 'filled';
            return 'empty';
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
            const next = String(val).replace(/\D/g, '').slice(0, 6);
            this.$emit('input', next);
            this.$emit('update:modelValue', next);
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
        onWrapClick() {},
    },
};
</script>

<style lang="scss" scoped>
.dreame-otp {
    position: relative;
    box-sizing: border-box;
    display: flex;
    flex-direction: row;
    align-items: flex-end;
    justify-content: space-between;
    width: 354px;
    max-width: 100%;
    height: calc(var(--dreame-space-48) - var(--dreame-space-2));

    &__hidden {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        opacity: 0;
        z-index: 2;
    }

    &__cell {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 47px;
    }

    &__digit {
        height: calc(var(--dreame-space-32) + var(--dreame-space-4));
        font-family: var(--dreame-font-family-system), -apple-system, sans-serif;
        font-size: var(--dreame-font-size-32);
        font-weight: var(--dreame-font-weight-medium);
        line-height: calc(var(--dreame-space-32) + var(--dreame-space-4));
        color: var(--dreame-input-text-value);
        text-align: center;
    }

    &__line {
        width: 47px;
        height: calc(var(--dreame-space-2) / 2);
        background: var(--dreame-text-tertiary);
    }

    &.is-empty .dreame-otp__line {
        background: var(--dreame-border-default);
    }

    &.is-error {
        .dreame-otp__digit {
            color: var(--dreame-input-border-error);
        }
        .dreame-otp__line {
            background: var(--dreame-input-border-error);
        }
    }

    &.is-disabled {
        .dreame-otp__digit {
            color: var(--dreame-text-disabled);
        }
        .dreame-otp__line {
            background: var(--dreame-icon-disabled);
        }
    }
}
</style>
