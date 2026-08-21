<template>
    <view class="dreame-pw" :class="rootClass">
        <input
            class="dreame-pw__field"
            :value="current"
            :placeholder="placeholder"
            :disabled="isDisabled"
            :password="!isVisible"
            :maxlength="maxlength"
            placeholder-class="dreame-pw__ph"
            @input="onInput"
            @focus="onFocus"
            @blur="onBlur"
        />
        <view class="dreame-pw__icons">
            <view
                v-if="showClear"
                class="dreame-pw__icon"
                @click.stop="onClear"
            >
                <image
                    class="dreame-pw__glyph dreame-pw__glyph--clear"
                    src="/static/input/icon-clear.svg"
                    mode="aspectFit"
                />
            </view>
            <view class="dreame-pw__icon" @click.stop="onToggle">
                <image
                    class="dreame-pw__glyph"
                    :class="eyeGlyphClass"
                    :src="eyeSrc"
                    mode="aspectFit"
                />
            </view>
        </view>
    </view>
</template>

<script>
/**
 * dreame-input-password
 * 支持清除、显示与隐藏密码。
 */
export default {
    name: 'DreameInputPassword',
    props: {
        value: { type: [String, Number], default: undefined },
        modelValue: { type: [String, Number], default: undefined },
        placeholder: { type: String, default: '请输入密码' },
        disabled: { type: Boolean, default: false },
        error: { type: Boolean, default: false },
        visible: { type: Boolean, default: false },
        maxlength: { type: [String, Number], default: 32 },
        previewState: { type: String, default: '' },
        previewVisible: { type: Boolean, default: undefined },
    },
    data() {
        return {
            focused: false,
            innerVisible: false,
        };
    },
    watch: {
        visible: {
            immediate: true,
            handler(val) {
                this.innerVisible = !!val;
            },
        },
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
            return 'empty';
        },
        isVisible() {
            if (this.previewVisible !== undefined) return this.previewVisible;
            return this.innerVisible;
        },
        isDisabled() {
            return this.disabled || this.previewState === 'disabled';
        },
        showClear() {
            return true;
        },
        eyeSrc() {
            if (this.visualState === 'disabled') {
                return '/static/input/icon-password-hide-disabled.svg';
            }
            return this.isVisible
                ? '/static/input/icon-password-show.svg'
                : '/static/input/icon-password-hide.svg';
        },
        eyeGlyphClass() {
            if (this.visualState === 'disabled') return 'dreame-pw__glyph--hide';
            return this.isVisible ? 'dreame-pw__glyph--show' : 'dreame-pw__glyph--hide';
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
        onClear() {
            if (this.previewState || this.isDisabled) return;
            this.emitVal('');
            this.$emit('clear');
        },
        onToggle() {
            if (this.previewState || this.isDisabled) return;
            const next = !this.isVisible;
            this.innerVisible = next;
            this.$emit('update:visible', next);
            this.$emit('toggle', next);
        },
    },
};
</script>

<style lang="scss" scoped>
.dreame-pw {
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

    &__icons {
        display: flex;
        flex-direction: row;
        align-items: center;
        flex-shrink: 0;
        margin-left: var(--dreame-space-12);
        gap: var(--dreame-space-12);
    }

    &__icon {
        position: relative;
        width: var(--dreame-space-24);
        height: var(--dreame-space-24);
        flex-shrink: 0;
        overflow: hidden;
    }

    &__glyph {
        position: absolute;
        display: block;
    }

    &__glyph--clear {
        left: 3px;
        top: 3px;
        width: 18px;
        height: 18px;
    }

    &__glyph--hide {
        left: 3px;
        top: 9px;
        width: 17.5px;
        height: 7.08px;
    }

    &__glyph--show {
        left: 3px;
        top: 4px;
        width: 18px;
        height: 15px;
    }

    &.is-empty .dreame-pw__field {
        color: var(--dreame-input-text-placeholder);
    }

    &.is-focus {
        border-color: var(--dreame-input-border-focus);
    }

    &.is-error {
        border-color: var(--dreame-input-border-error);
    }

    &.is-disabled {
        background: var(--dreame-input-bg-disabled);

        .dreame-pw__field {
            color: var(--dreame-text-disabled);
        }
    }
}

/* #ifdef H5 */
.dreame-pw__icon {
    cursor: pointer;
}
.dreame-pw.is-disabled .dreame-pw__icon {
    cursor: default;
}
/* #endif */
</style>
