<template>
    <button
        class="dreame-btn"
        :class="rootClass"
        :hover-class="hoverClass"
        :hover-start-time="0"
        :hover-stay-time="200"
        :disabled="!interactive"
        @click="onClick"
    >
        <view v-if="visualState === 'loading'" class="dreame-btn__spin" />
        <text v-else class="dreame-btn__label">{{ text }}</text>
    </button>
</template>

<script>
/**
 * dreame-button
 *
 * @property {String | Number} text          按钮文案
 * @property {String}          variant       primary | secondary（默认 primary）
 * @property {String}          size          s | m | l（默认 l，335×48 页底主按钮）
 * @property {Boolean}         disabled      禁用
 * @property {Boolean}         loading       加载中，不展示文案
 * @property {Boolean}         warning       仅 secondary：警示文案色
 * @property {String}          previewState  文档预览状态覆盖
 *
 * @example <dreame-button text="确定" @click="onOk" />
 * @example <dreame-button variant="secondary" text="取消" />
 */
export default {
    name: 'DreameButton',
    props: {
        text: {
            type: [String, Number],
            default: '按钮文案',
        },
        variant: {
            type: String,
            default: 'primary',
        },
        size: {
            type: String,
            default: 'l',
        },
        disabled: {
            type: Boolean,
            default: false,
        },
        loading: {
            type: Boolean,
            default: false,
        },
        warning: {
            type: Boolean,
            default: false,
        },
        previewState: {
            type: String,
            default: '',
        },
    },
    computed: {
        visualState() {
            if (this.previewState) return this.previewState;
            if (this.disabled) return 'disabled';
            if (this.loading) return 'loading';
            if (this.warning) return 'warning';
            return 'default';
        },
        interactive() {
            return (
                !this.disabled &&
                !this.loading &&
                this.previewState !== 'disabled' &&
                this.previewState !== 'loading'
            );
        },
        hoverClass() {
            if (!this.interactive || this.previewState) return 'none';
            return 'is-pressed';
        },
        rootClass() {
            return [
                'dreame-btn--' + this.variant,
                'dreame-btn--' + this.size,
                'is-' + this.visualState,
            ];
        },
    },
    methods: {
        onClick() {
            if (!this.interactive || this.previewState) return;
            this.$emit('click');
        },
    },
};
</script>

<style lang="scss" scoped>
.dreame-btn {
    box-sizing: border-box;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    align-self: flex-start;
    flex-grow: 0;
    flex-shrink: 0;
    margin: 0;
    border-radius: var(--dreame-radius-full);
    border-width: 0;
    border-style: solid;
    border-color: transparent;
    outline: none;
    line-height: var(--dreame-font-lineheight-tight);
    overflow: visible;

    &::after {
        border: none;
    }

    &__label {
        font-family: var(--dreame-font-family-system), -apple-system, sans-serif;
        font-weight: var(--dreame-font-weight-medium);
        text-align: center;
        white-space: nowrap;
    }

    &__spin {
        width: calc(var(--dreame-space-16) + var(--dreame-space-4));
        height: calc(var(--dreame-space-16) + var(--dreame-space-4));
        border-radius: var(--dreame-radius-full);
        background: conic-gradient(
            from 200deg,
            transparent 0%,
            var(--dreame-button-primary-bg-default) 38%,
            var(--dreame-button-primary-text-default) 88%,
            transparent 100%
        );
        -webkit-mask-image: radial-gradient(
            farthest-side,
            transparent calc(100% - var(--dreame-space-2)),
            var(--dreame-color-neutral-900) calc(100% - var(--dreame-space-2))
        );
        mask-image: radial-gradient(
            farthest-side,
            transparent calc(100% - var(--dreame-space-2)),
            var(--dreame-color-neutral-900) calc(100% - var(--dreame-space-2))
        );
        animation: dreame-spin 0.9s linear infinite;
    }

    &--s {
        width: 104px !important;
        max-width: 104px;
        height: calc(var(--dreame-space-32) + var(--dreame-space-4));
        padding: calc(var(--dreame-space-4) + var(--dreame-space-2)) var(--dreame-space-24);

        .dreame-btn__label {
            font-size: var(--dreame-font-size-14);
            line-height: calc(var(--dreame-space-16) + var(--dreame-space-2));
        }
    }

    &--m {
        width: 160px !important;
        max-width: 160px;
        height: 43px;
        padding: var(--dreame-space-4) calc(var(--dreame-space-16) + var(--dreame-space-4));

        .dreame-btn__label {
            font-size: var(--dreame-font-size-16);
            line-height: calc(var(--dreame-space-16) + var(--dreame-space-4));
        }
    }

    &--l {
        width: 335px !important;
        max-width: 335px;
        height: var(--dreame-space-48);
        padding: var(--dreame-space-4) calc(var(--dreame-space-16) + var(--dreame-space-4));

        .dreame-btn__label {
            font-size: var(--dreame-font-size-16);
            line-height: calc(var(--dreame-space-16) + var(--dreame-space-4));
        }
    }

    &--primary {
        background: var(--dreame-button-primary-bg-default);

        .dreame-btn__label {
            color: var(--dreame-button-primary-text-default);
        }

        &.is-pressed {
            background: var(--dreame-button-primary-bg-pressed);
        }

        &.is-disabled {
            background: var(--dreame-button-primary-bg-disabled);

            .dreame-btn__label {
                color: var(--dreame-button-primary-text-disabled);
            }
        }

        &.is-loading {
            background: var(--dreame-button-primary-bg-default);
        }
    }

    &--secondary {
        &.is-default,
        &.is-warning {
            background: var(--dreame-button-secondary-bg-default);
            box-shadow: inset 0 0 0 1px var(--dreame-button-secondary-border-default);
        }

        &.is-default .dreame-btn__label {
            color: var(--dreame-button-secondary-text-default);
        }

        &.is-warning .dreame-btn__label {
            color: var(--dreame-text-error);
        }

        &.is-pressed {
            background: var(--dreame-button-secondary-bg-pressed);
            box-shadow: inset 0 0 0 1px var(--dreame-button-secondary-border-default);

            .dreame-btn__label {
                color: var(--dreame-button-secondary-text-default);
            }
        }

        &.is-disabled {
            background: var(--dreame-button-secondary-bg-disabled);
            box-shadow: inset 0 0 0 1px var(--dreame-button-secondary-border-default);

            .dreame-btn__label {
                color: var(--dreame-button-secondary-text-disabled);
            }
        }
    }
}

/* #ifdef H5 */
@media (hover: hover) {
    .dreame-btn--primary.is-default:hover {
        background: var(--dreame-button-primary-bg-hover);
    }
    .dreame-btn--secondary.is-default:hover {
        background: var(--dreame-button-secondary-bg-hover);
        box-shadow: inset 0 0 0 1px var(--dreame-button-secondary-border-hover);
    }
}
/* #endif */

@keyframes dreame-spin {
    from {
        transform: rotate(0deg);
    }
    to {
        transform: rotate(360deg);
    }
}
</style>
