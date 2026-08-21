<template>
    <view v-if="visible" class="dreame-dialog" :class="rootClass" @click.stop>
        <view class="dreame-dialog__stage">
            <view class="dreame-dialog__card">
                <view
                    v-if="closeIcon"
                    class="dreame-dialog__close"
                    @click="onClose"
                >
                    <view class="dreame-dialog__close-line is-a" />
                    <view class="dreame-dialog__close-line is-b" />
                </view>
                <view v-if="showTitle || content" class="dreame-dialog__content">
                    <text v-if="showTitle" class="dreame-dialog__title">{{ title }}</text>
                    <text v-if="content" class="dreame-dialog__body">{{ content }}</text>
                </view>
                <view v-if="showInput" class="dreame-dialog__field">
                    <dreame-input
                        :value="inputValue"
                        :placeholder="inputPlaceholder"
                        @input="onInput"
                    />
                </view>
                <view class="dreame-dialog__actions" :class="'is-' + buttonLayout">
                    <view
                        v-for="btn in actionList"
                        :key="btn.key"
                        class="dreame-dialog__btn"
                    >
                        <dreame-button
                            :text="btn.text"
                            :variant="btn.variant"
                            :warning="btn.warning"
                            size="m"
                            @click="btn.onClick"
                        />
                    </view>
                </view>
            </view>
            <view class="dreame-dialog__home">
                <view class="dreame-dialog__home-bar" />
            </view>
        </view>
    </view>
</template>

<script>
/**
 * dreame-dialog
 * placement=bottom 时渲染为底部 Sheet，操作区复用 dreame-button。
 */
export default {
    name: 'DreameDialog',
    props: {
        show: { type: Boolean, default: false },
        preview: { type: Boolean, default: false },
        framed: { type: Boolean, default: false },
        type: { type: String, default: 'standard' },
        placement: { type: String, default: 'center' },
        title: { type: String, default: '弹窗标题' },
        content: {
            type: String,
            default: '这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本',
        },
        actions: { type: [Number, String], default: 2 },
        buttonLayout: { type: String, default: 'horizontal' },
        closeIcon: { type: Boolean, default: false },
        warning: { type: Boolean, default: false },
        confirmText: { type: String, default: '确定' },
        cancelText: { type: String, default: '取消' },
        showInput: { type: Boolean, default: false },
        inputValue: { type: String, default: '' },
        inputPlaceholder: { type: String, default: '请输入' },
    },
    computed: {
        visible() {
            return this.preview || this.show;
        },
        showTitle() {
            return !!this.title;
        },
        actionCount() {
            return Number(this.actions) === 1 ? 1 : 2;
        },
        actionList() {
            const confirm = {
                key: 'ok',
                text: this.confirmText,
                variant: this.warning ? 'secondary' : 'primary',
                warning: this.warning,
                onClick: this.onConfirm,
            };
            const cancel = {
                key: 'cancel',
                text: this.cancelText,
                variant: 'secondary',
                warning: false,
                onClick: this.onCancel,
            };
            const extraPrimary = {
                key: 'ok2',
                text: this.confirmText,
                variant: 'primary',
                warning: false,
                onClick: this.onConfirm,
            };
            if (this.buttonLayout === 'vertical-style-1') {
                if (this.actionCount === 1) return [confirm, extraPrimary];
                return [cancel, confirm];
            }
            if (this.buttonLayout === 'vertical-style-2') {
                return [confirm, cancel];
            }
            if (this.actionCount === 1) return [confirm];
            return [cancel, confirm];
        },
        rootClass() {
            return [
                'is-' + this.placement,
                'is-' + this.type,
                this.preview ? 'is-preview' : this.framed ? 'is-framed' : 'is-live',
                this.closeIcon ? 'has-close' : '',
                this.showInput ? 'has-input' : '',
            ];
        },
    },
    methods: {
        onConfirm() {
            this.$emit('confirm');
            if (!this.preview) this.$emit('update:show', false);
        },
        onCancel() {
            this.$emit('cancel');
            if (!this.preview) this.$emit('update:show', false);
        },
        onClose() {
            this.$emit('close');
            if (!this.preview) this.$emit('update:show', false);
        },
        onInput(val) {
            this.$emit('update:inputValue', val);
            this.$emit('input', val);
        },
    },
};
</script>

<style lang="scss" scoped>
.dreame-dialog {
    $phone-w: 402px;
    $phone-h: 874px;

    &__stage {
        position: relative;
        box-sizing: border-box;
        width: $phone-w;
        height: $phone-h;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 0 var(--dreame-space-32);
        background: var(--dreame-backdrop-default);
    }

    &.is-live,
    &.is-framed {
        position: fixed;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
        z-index: 1000;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
    }

    &.is-live {
        background: var(--dreame-backdrop-default);
    }

    &.is-live &__stage {
        width: 100%;
        height: 100%;
        border-radius: 0;
        background: transparent;
        padding: var(--dreame-space-32);
        transform: none;
    }

    &.is-framed {
        background: var(--dreame-backdrop-light);
    }

    &.is-framed &__stage {
        width: $phone-w;
        height: $phone-h;
        flex-shrink: 0;
        transform-origin: center center;
        // 字符串绕过 Sass，按视口把 402×874 整框缩小，不裁切
        transform: #{"scale(min(1, 80dvh / 874px, 72dvw / 402px))"};
    }

    &.is-preview {
        position: relative;
        z-index: 1;
        display: block;
        width: 100%;
        height: auto;
        aspect-ratio: 402 / 874;
        overflow: hidden;
        container-type: inline-size;
        flex: none;
    }

    &.is-preview &__stage {
        position: absolute;
        left: 0;
        top: 0;
        width: $phone-w;
        height: $phone-h;
        transform-origin: top left;
        transform: #{"scale(calc(100cqw / 402px))"};
    }

    &.is-bottom &__stage {
        justify-content: flex-end;
        padding: 0;
    }

    &__home {
        position: absolute;
        left: 0;
        right: 0;
        bottom: 0;
        height: calc(var(--dreame-space-32) + var(--dreame-space-2));
        display: flex;
        align-items: flex-end;
        justify-content: center;
        padding: var(--dreame-space-8) var(--dreame-space-12);
        pointer-events: none;
        z-index: 2;
    }

    &__home-bar {
        width: 121px;
        height: var(--dreame-space-4);
        border-radius: var(--dreame-radius-8);
        background: var(--dreame-text-onbrand);
    }

    &.is-bottom &__home-bar {
        background: var(--dreame-text-primary);
    }

    &.is-live &__home {
        display: none;
    }

    &__card {
        position: relative;
        z-index: 1;
        box-sizing: border-box;
        width: 335px;
        max-width: 100%;
        padding: calc(var(--dreame-space-16) + var(--dreame-space-4));
        border-radius: var(--dreame-radius-24);
        background: var(--dreame-dialog-bg);
        display: flex;
        flex-direction: column;
        align-items: stretch;
        gap: var(--dreame-space-24);
        flex-shrink: 0;
    }

    &.is-bottom &__card {
        width: 100%;
        border-radius: var(--dreame-radius-24) var(--dreame-radius-24) 0 0;
        padding-bottom: calc(var(--dreame-space-32) + var(--dreame-space-2));
    }

    &.has-close &__card {
        padding-top: var(--dreame-space-32);
    }

    &.has-input &__card {
        gap: var(--dreame-space-16);
        align-items: center;
    }

    &__close {
        position: absolute;
        top: var(--dreame-space-16);
        right: var(--dreame-space-16);
        width: var(--dreame-space-24);
        height: var(--dreame-space-24);
    }

    &__close-line {
        position: absolute;
        left: 11px;
        top: 3px;
        width: var(--dreame-space-2);
        height: calc(var(--dreame-space-16) + var(--dreame-space-2));
        background: var(--dreame-icon-primary);
    }

    &__close-line.is-a {
        transform: rotate(45deg);
    }

    &__close-line.is-b {
        transform: rotate(-45deg);
    }

    &__content {
        display: flex;
        flex-direction: column;
        align-items: stretch;
        gap: var(--dreame-space-16);
        width: 100%;
    }

    &__title {
        font-family: var(--dreame-font-family-system), -apple-system, sans-serif;
        font-size: var(--dreame-font-size-16);
        font-weight: var(--dreame-font-weight-medium);
        line-height: calc(var(--dreame-space-16) + var(--dreame-space-4));
        color: var(--dreame-text-primary);
        text-align: center;
    }

    &__body {
        font-family: var(--dreame-font-family-system), -apple-system, sans-serif;
        font-size: var(--dreame-font-size-14);
        font-weight: var(--dreame-font-weight-regular);
        line-height: calc(var(--dreame-space-16) + var(--dreame-space-2));
        color: var(--dreame-text-tertiary);
        text-align: center;
    }

    &.is-bottom &__body {
        text-align: left;
    }

    &__field {
        width: 100%;
    }

    &__field :deep(.dreame-input) {
        width: 100%;
        max-width: 100%;
    }

    &__actions {
        display: flex;
        flex-direction: row;
        align-items: center;
        gap: var(--dreame-space-12);
        width: 100%;
    }

    &__actions.is-vertical-style-1,
    &__actions.is-vertical-style-2 {
        flex-direction: column;
        align-items: stretch;
    }

    &__btn {
        flex: 1;
        min-width: 0;
        width: 100%;
    }

    &__btn :deep(.dreame-btn) {
        width: 100% !important;
        max-width: 100% !important;
        height: calc(var(--dreame-space-48) - var(--dreame-space-2));
        align-self: stretch;
    }
}
</style>
