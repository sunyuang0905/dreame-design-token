<template>
    <view v-if="visible" class="dreame-toast" :class="rootClass">
        <view class="dreame-toast__pill">
            <text class="dreame-toast__msg">{{ message }}</text>
        </view>
    </view>
</template>

<script>
/**
 * dreame-toast
 * 用于短时、无操作项的反馈信息。
 */
export default {
    name: 'DreameToast',
    props: {
        show: { type: Boolean, default: false },
        preview: { type: Boolean, default: false },
        message: { type: String, default: 'Message text' },
        position: { type: String, default: 'bottom' },
        duration: { type: [Number, String], default: 2000 },
    },
    data() {
        return { timer: null };
    },
    computed: {
        visible() {
            return this.preview || this.show;
        },
        place() {
            return this.position === 'center' ? 'center' : 'bottom';
        },
        rootClass() {
            return [
                this.preview ? 'is-preview' : 'is-live',
                'is-' + this.place,
            ];
        },
    },
    watch: {
        show: {
            immediate: true,
            handler(val) {
                if (this.preview) return;
                if (val) this.startTimer();
                else this.clearTimer();
            },
        },
    },
    beforeDestroy() {
        this.clearTimer();
    },
    unmounted() {
        this.clearTimer();
    },
    methods: {
        startTimer() {
            this.clearTimer();
            const ms = Number(this.duration) || 0;
            if (ms <= 0) return;
            this.timer = setTimeout(() => this.dismiss(), ms);
        },
        clearTimer() {
            if (this.timer) {
                clearTimeout(this.timer);
                this.timer = null;
            }
        },
        dismiss() {
            this.clearTimer();
            this.$emit('update:show', false);
            this.$emit('close');
        },
    },
};
</script>

<style lang="scss" scoped>
.dreame-toast {
    pointer-events: none;

    &.is-preview {
        position: relative;
        display: inline-flex;
        max-width: 100%;
    }

    &.is-live {
        position: fixed;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
        z-index: 1100;
        display: flex;
        justify-content: center;
        box-sizing: border-box;
    }

    &.is-live.is-bottom {
        align-items: flex-end;
        padding-bottom: calc(var(--dreame-space-32) + var(--dreame-space-2));
    }

    &.is-live.is-center {
        align-items: center;
        padding: 0 calc(var(--dreame-space-16) + var(--dreame-space-4));
    }

    &__pill {
        box-sizing: border-box;
        display: inline-flex;
        flex-direction: row;
        align-items: center;
        justify-content: center;
        min-height: calc(var(--dreame-space-48) + var(--dreame-space-4));
        max-width: 354px;
        width: auto;
        padding: var(--dreame-space-16) var(--dreame-space-32);
        border-radius: var(--dreame-radius-full);
        background: var(--dreame-dialog-bg);
        box-shadow: 0 var(--dreame-space-4) var(--dreame-space-12) calc(-1 * var(--dreame-space-4))
            var(--dreame-color-blackalpha-12);
    }

    &__msg {
        font-family: var(--dreame-font-family-system), -apple-system, sans-serif;
        font-size: var(--dreame-font-size-14);
        font-weight: var(--dreame-font-weight-regular);
        line-height: var(--dreame-font-lineheight-normal);
        text-align: center;
        color: var(--dreame-text-primary);
        word-break: break-word;
    }
}
</style>
