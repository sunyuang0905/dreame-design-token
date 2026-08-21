<template>
    <view class="dreame-select" @click="onOpen">
        <view class="dreame-select__field" :class="rootClass">
            <text class="dreame-select__value">{{ displayText }}</text>
            <view class="dreame-select__chevron">
                <image class="dreame-select__chevron-glyph" :src="chevronSrc" mode="aspectFit" />
            </view>
        </view>
        <text v-if="showError" class="dreame-select__hint">{{ errorMessage }}</text>
    </view>
</template>

<script>
import chevronDisabledIcon from '../../assets/input/icon-chevron-disabled.svg';
import chevronIcon from '../../assets/input/icon-chevron.svg';

/**
 * dreame-input-select
 * 点击事件由外部 picker 或 sheet 接管。
 */
export default {
    name: 'DreameInputSelect',
    props: {
        value: { type: String, default: '' },
        placeholder: { type: String, default: '请选择' },
        disabled: { type: Boolean, default: false },
        error: { type: Boolean, default: false },
        errorMessage: { type: String, default: '检测到您的wifi存在风险，请更换wifi配网' },
        previewState: { type: String, default: '' },
    },
    computed: {
        visualState() {
            if (this.previewState) return this.previewState;
            if (this.disabled) return 'disabled';
            if (this.error) return 'error';
            if (this.value) return 'selected';
            return 'default';
        },
        isDisabled() {
            return this.disabled || this.previewState === 'disabled';
        },
        showError() {
            return this.visualState === 'error';
        },
        displayText() {
            if (this.visualState === 'default') return this.placeholder;
            return this.value || this.placeholder;
        },
        chevronSrc() {
            return this.visualState === 'disabled'
                ? chevronDisabledIcon
                : chevronIcon;
        },
        rootClass() {
            return ['is-' + this.visualState];
        },
    },
    methods: {
        onOpen() {
            if (this.previewState || this.isDisabled) return;
            this.$emit('click');
            this.$emit('open');
        },
    },
};
</script>

<style lang="scss" scoped>
.dreame-select {
    width: 354px;
    max-width: 100%;

    &__field {
        box-sizing: border-box;
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-between;
        height: var(--dreame-space-48);
        padding: 0 var(--dreame-space-12);
        border-radius: var(--dreame-radius-8);
        border-width: var(--dreame-space-2);
        border-style: solid;
        border-color: transparent;
        background: var(--dreame-input-bg-default);
    }

    &__value {
        flex: 1;
        min-width: 0;
        font-family: var(--dreame-font-family-system), -apple-system, sans-serif;
        font-size: var(--dreame-font-size-16);
        font-weight: var(--dreame-font-weight-regular);
        line-height: calc(var(--dreame-space-16) + var(--dreame-space-4));
        color: var(--dreame-input-text-value);
    }

    &__chevron {
        position: relative;
        width: var(--dreame-space-24);
        height: var(--dreame-space-24);
        flex-shrink: 0;
        overflow: hidden;
    }

    &__chevron-glyph {
        position: absolute;
        left: 50%;
        top: 50%;
        width: 12.35px;
        height: 6.77px;
        transform: translate(-50%, -50%) rotate(90deg);
    }

    &__hint {
        display: block;
        margin-top: var(--dreame-space-8);
        font-family: var(--dreame-font-family-system), -apple-system, sans-serif;
        font-size: var(--dreame-font-size-12);
        line-height: var(--dreame-space-16);
        color: var(--dreame-text-error);
    }

    &__field.is-default .dreame-select__value {
        color: var(--dreame-input-text-placeholder);
    }

    &__field.is-error {
        border-color: var(--dreame-input-border-error);

        .dreame-select__value {
            color: var(--dreame-text-error);
            font-weight: var(--dreame-font-weight-medium);
        }
    }

    &__field.is-disabled {
        background: var(--dreame-input-bg-disabled);

        .dreame-select__value {
            color: var(--dreame-text-disabled);
        }
    }
}
</style>
