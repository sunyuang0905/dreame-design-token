<template>
    <view class="dreame-step" :class="rootClass">
        <text v-if="isFive" class="dreame-step__label">
            <text class="dreame-step__cur">{{ currentIndex }}</text>
            <text class="dreame-step__rest">/{{ stepCount }}</text>
        </text>
        <text v-else class="dreame-step__label dreame-step__label--three">{{ currentIndex }}/{{ stepCount }}</text>
        <view class="dreame-step__bars">
            <view
                v-for="n in stepCount"
                :key="n"
                class="dreame-step__bar"
                :class="{ 'is-on': n <= currentIndex }"
            />
        </view>
    </view>
</template>

<script>
/**
 * dreame-step-indicator
 * 适用于三步或五步流程进度展示。
 *
 * @property {Number | String} steps    5 | 3，默认 5
 * @property {Number | String} current  当前步，从 1 起
 *
 * @example <dreame-step-indicator :current="2" />
 * @example <dreame-step-indicator :steps="3" :current="1" />
 */
export default {
    name: 'DreameStepIndicator',
    props: {
        steps: {
            type: [Number, String],
            default: 5,
        },
        current: {
            type: [Number, String],
            default: 1,
        },
    },
    computed: {
        stepCount() {
            return Number(this.steps) === 3 ? 3 : 5;
        },
        isFive() {
            return this.stepCount === 5;
        },
        currentIndex() {
            const n = Number(this.current) || 1;
            if (n < 1) return 1;
            if (n > this.stepCount) return this.stepCount;
            return n;
        },
        rootClass() {
            return [
                this.isFive ? 'is-five' : 'is-three',
                !this.isFive && this.currentIndex > 1 ? 'is-muted' : '',
            ];
        },
    },
};
</script>

<style lang="scss" scoped>
.dreame-step {
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    align-items: center;
    flex-shrink: 0;

    &.is-five {
        width: 113px;
        height: var(--dreame-space-32);
        justify-content: space-between;
    }

    &.is-three {
        width: 67px;
        height: 35px;
        justify-content: space-between;
    }

    &__label {
        font-family: var(--dreame-font-family-system), -apple-system, sans-serif;
        font-size: var(--dreame-font-size-16);
        font-weight: var(--dreame-font-weight-medium);
        line-height: calc(var(--dreame-space-16) + var(--dreame-space-4));
        text-align: center;
        white-space: nowrap;
    }

    &__cur {
        color: var(--dreame-icon-brand);
    }

    &__rest {
        color: var(--dreame-icon-tertiary);
    }

    &__label--three {
        font-size: var(--dreame-font-size-18);
        font-weight: var(--dreame-font-weight-regular);
        line-height: calc(var(--dreame-space-16) + var(--dreame-space-4) + var(--dreame-space-2));
        color: var(--dreame-icon-brand);
    }

    &.is-muted &__label--three {
        color: var(--dreame-icon-tertiary);
    }

    &__bars {
        display: flex;
        flex-direction: row;
        align-items: center;
        width: 100%;
    }

    &.is-five &__bars {
        gap: 1.387px;
    }

    &.is-three &__bars {
        gap: var(--dreame-space-2);
    }

    &__bar {
        height: var(--dreame-space-2);
        border-radius: calc(var(--dreame-space-2) / 2);
        background: var(--dreame-icon-tertiary);
        flex: none;
        max-width: 21.491px;
    }

    &.is-five &__bar {
        width: 21.491px;
    }

    &.is-three &__bar {
        width: 21px;
        max-width: 21px;
    }

    &__bar.is-on {
        background: var(--dreame-icon-brand);
    }
}
</style>
