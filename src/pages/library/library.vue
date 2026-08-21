<template>
  <view class="shell" :class="{ 'theme-dark': dark }">
    <view class="side">
      <text class="side__name">DREAME</text>
      <view
        class="side__item"
        :class="{ 'is-on': section === 'button' }"
        @click="section = 'button'"
      >
        <text class="side__label">Button</text>
      </view>
      <view
        class="side__item"
        :class="{ 'is-on': section === 'input' }"
        @click="section = 'input'"
      >
        <text class="side__label">Input</text>
      </view>
      <view
        class="side__item"
        :class="{ 'is-on': section === 'dialog' }"
        @click="section = 'dialog'"
      >
        <text class="side__label">Dialog</text>
      </view>
      <view
        class="side__item"
        :class="{ 'is-on': section === 'step' }"
        @click="section = 'step'"
      >
        <text class="side__label">Step</text>
      </view>
      <view
        class="side__item"
        :class="{ 'is-on': section === 'toast' }"
        @click="section = 'toast'"
      >
        <text class="side__label">Toast</text>
      </view>
      <view class="side__theme">
        <text class="side__theme-label">暗色</text>
        <dreame-switch v-model="dark" />
      </view>
    </view>

    <view class="main">
      <view v-if="section === 'button'">
        <text class="page__name">Button</text>

        <text class="h">用法</text>
        <view class="code">
          <text class="code__snip">&lt;dreame-button text="确定" @click="onOk" /&gt;</text>
          <text class="code__snip">&lt;dreame-button variant="secondary" text="取消" /&gt;</text>
          <text class="code__snip">&lt;dreame-button loading /&gt;</text>
          <text class="code__snip">&lt;dreame-button text="不可用" disabled /&gt;</text>
          <text class="code__meta">variant = primary | secondary，默认 primary</text>
          <text class="code__meta">size = s | m | l，默认 l（335×48）</text>
        </view>
        <view class="demo">
          <text class="demo__cap">主按钮 / 次按钮</text>
          <dreame-button variant="secondary" text="取消" @click="ping('取消')" />
          <view class="demo__space" />
          <dreame-button text="确定" @click="ping('确定')" />
          <view class="demo__space" />
          <text class="demo__cap">加载 / 禁用</text>
          <dreame-button text="加载中" loading />
          <view class="demo__space" />
          <dreame-button text="不可用" disabled />
        </view>

        <text class="h">规格</text>
        <view v-for="row in buttonRows" :key="row.key" class="spec">
          <text class="spec__label">{{ row.label }}</text>
          <view class="spec__btns">
            <dreame-button size="s" :variant="row.variant" :previewState="row.state" :text="row.text" />
            <view class="spec__gap" />
            <dreame-button size="m" :variant="row.variant" :previewState="row.state" :text="row.text" />
            <view class="spec__gap" />
            <dreame-button size="l" :variant="row.variant" :previewState="row.state" :text="row.text" />
          </view>
        </view>
      </view>

      <view v-else-if="section === 'input'">
        <text class="page__name">Input</text>

        <text class="h">用法</text>
        <view class="code">
          <text class="code__snip">&lt;dreame-input v-model="text" placeholder="请输入" /&gt;</text>
          <text class="code__snip">&lt;dreame-input-password v-model="pwd" :visible="show" @toggle="onToggle" /&gt;</text>
          <text class="code__snip">&lt;dreame-input-otp v-model="code" /&gt;</text>
          <text class="code__snip">&lt;dreame-input-select :value="name" placeholder="请选择" @click="onOpen" /&gt;</text>
          <text class="code__meta">error 错误态 · disabled 禁用</text>
        </view>
        <view class="demo">
          <text class="demo__cap">Text</text>
          <dreame-input v-model="textValue" placeholder="请输入" />
          <view class="demo__space" />
          <text class="demo__cap">Password</text>
          <dreame-input-password
            v-model="passwordValue"
            :visible="passwordVisible"
            @toggle="passwordVisible = !passwordVisible"
          />
          <view class="demo__space" />
          <text class="demo__cap">OTP</text>
          <dreame-input-otp v-model="otpValue" />
          <view class="demo__space" />
          <text class="demo__cap">Select</text>
          <dreame-input-select
            :value="selectValue"
            placeholder="请选择"
            @click="ping(selectValue)"
          />
        </view>

        <text class="h">Input / Text</text>
        <view v-for="row in textRows" :key="row.key" class="spec">
          <text class="spec__label">{{ row.label }}</text>
          <dreame-input
            :value="row.value"
            :placeholder="row.placeholder"
            :previewState="row.state"
          />
        </view>

        <text class="h">Input / Password</text>
        <view v-for="row in passwordRows" :key="row.key" class="spec">
          <text class="spec__label">{{ row.label }}</text>
          <dreame-input-password
            :value="row.value"
            :previewState="row.state"
            :previewVisible="row.visible"
            placeholder="请输入密码"
          />
        </view>

        <text class="h">Input / OTP</text>
        <view v-for="row in otpRows" :key="row.key" class="spec">
          <text class="spec__label">{{ row.label }}</text>
          <dreame-input-otp :value="row.value" :previewState="row.state" />
        </view>

        <text class="h">Input / Select</text>
        <view v-for="row in selectRows" :key="row.key" class="spec">
          <text class="spec__label">{{ row.label }}</text>
          <dreame-input-select
            :value="row.value"
            :placeholder="row.placeholder"
            :previewState="row.state"
            :errorMessage="row.hint"
          />
        </view>
      </view>

      <view v-else-if="section === 'dialog'">
        <text class="page__name">Dialog</text>

        <text class="h">用法</text>
        <view class="code">
          <text class="code__snip">&lt;dreame-dialog :show="show" title="弹窗标题" content="这是一些文本" @confirm="onOk" @cancel="onCancel" /&gt;</text>
          <text class="code__snip">&lt;dreame-dialog :show="show" :actions="1" confirmText="我知道了" /&gt;</text>
          <text class="code__snip">&lt;dreame-dialog :show="show" placement="bottom" /&gt;</text>
          <text class="code__meta">actions = 1 | 2 · buttonLayout = horizontal | vertical-style-1 | vertical-style-2</text>
          <text class="code__meta">placement = center | bottom（bottom 即 Sheet）· closeIcon · warning</text>
          <text class="code__meta">本页手机画框只给预览；业务里写 :show，蒙层铺满当前页</text>
        </view>
        <view class="demo">
          <text class="demo__cap">点一下打开</text>
          <dreame-button text="双按钮" size="m" @click="openDialog('basic')" />
          <view class="demo__space" />
          <dreame-button text="单按钮" size="m" @click="openDialog('one')" />
          <view class="demo__space" />
          <dreame-button text="底部 Sheet" size="m" @click="openDialog('sheet')" />
          <view class="demo__space" />
          <dreame-button text="带输入" size="m" @click="openDialog('input')" />
        </view>

        <text class="h">规格</text>
        <view class="dialog-grid">
          <view v-for="row in dialogRows" :key="row.key" class="dialog-cell">
            <text class="dialog-cell__label">{{ row.label }}</text>
            <dreame-dialog
              preview
              :type="row.type"
              :placement="row.placement"
              :title="row.title"
              :content="row.content"
              :actions="row.actions"
              :buttonLayout="row.buttonLayout"
              :closeIcon="row.closeIcon"
              :warning="row.warning"
              :showInput="row.showInput"
              :inputPlaceholder="row.inputPlaceholder"
              confirmText="确定"
              cancelText="取消"
            />
          </view>
        </view>
      </view>

      <view v-else-if="section === 'step'">
        <text class="page__name">Step</text>

        <text class="h">用法</text>
        <view class="code">
          <text class="code__snip">&lt;dreame-step-indicator :current="2" /&gt;</text>
          <text class="code__snip">&lt;dreame-step-indicator :steps="3" :current="1" /&gt;</text>
          <text class="code__meta">steps = 5 | 3，默认 5 · current 从 1 起</text>
          <text class="code__meta">适用于三步或五步流程进度展示</text>
        </view>
        <view class="demo">
          <text class="demo__cap">点一下切换当前步</text>
          <view @click="cycleStep(5)">
            <dreame-step-indicator :current="stepFive" />
          </view>
          <view class="demo__space" />
          <view @click="cycleStep(3)">
            <dreame-step-indicator :steps="3" :current="stepThree" />
          </view>
        </view>

        <text class="h">Five Steps</text>
        <view class="step-grid">
          <view v-for="n in 5" :key="'f' + n" class="step-cell">
            <text class="step-cell__label">current={{ n }}</text>
            <dreame-step-indicator :steps="5" :current="n" />
          </view>
        </view>

        <text class="h">Three Steps</text>
        <view class="step-grid">
          <view v-for="n in 3" :key="'t' + n" class="step-cell">
            <text class="step-cell__label">current={{ n }}</text>
            <dreame-step-indicator :steps="3" :current="n" />
          </view>
        </view>
      </view>

      <view v-else-if="section === 'toast'">
        <text class="page__name">Toast</text>

        <text class="h">用法</text>
        <view class="code">
          <text class="code__snip">&lt;dreame-toast :show="show" message="对方已接受分享" /&gt;</text>
          <text class="code__snip">showToast({ message: '对方已接受分享', position: 'bottom' })</text>
          <text class="code__meta">position = bottom | center，默认 bottom（贴在 Home Indicator 之上）</text>
          <text class="code__meta">适用于短时、无操作项的反馈信息</text>
        </view>
        <view class="demo">
          <text class="demo__cap">点一下弹出</text>
          <dreame-button variant="secondary" text="底部 Toast" size="m" @click="openToast('bottom')" />
          <view class="demo__space" />
          <dreame-button variant="secondary" text="居中 Toast" size="m" @click="openToast('center')" />
        </view>

        <text class="h">规格</text>
        <view v-for="row in toastRows" :key="row.key" class="spec">
          <text class="spec__label">{{ row.label }}</text>
          <dreame-toast preview :message="row.message" />
        </view>
      </view>
    </view>

    <dreame-dialog
      framed
      :show="liveDialog.show"
      :type="liveDialog.type"
      :placement="liveDialog.placement"
      :title="liveDialog.title"
      :content="liveDialog.content"
      :actions="liveDialog.actions"
      :buttonLayout="liveDialog.buttonLayout"
      :closeIcon="liveDialog.closeIcon"
      :showInput="liveDialog.showInput"
      :inputValue="liveDialog.inputValue"
      :inputPlaceholder="liveDialog.inputPlaceholder"
      confirmText="确定"
      cancelText="取消"
      @confirm="closeDialog"
      @cancel="closeDialog"
      @close="closeDialog"
      @input="liveDialog.inputValue = $event"
    />

    <dreame-toast
      :show="liveToast.show"
      :message="liveToast.message"
      :position="liveToast.position"
      @close="liveToast.show = false"
    />
  </view>
</template>

<script>
export default {
  data() {
    return {
      section: 'toast',
      dark: false,
      stepFive: 1,
      stepThree: 1,
      textValue: '',
      passwordValue: '',
      passwordVisible: false,
      otpValue: '',
      selectValue: '小猪仔的家庭',
      liveToast: {
        show: false,
        message: '对方已接受分享',
        position: 'bottom'
      },
      liveDialog: {
        show: false,
        type: 'standard',
        placement: 'center',
        title: '弹窗标题',
        content: '这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本',
        actions: 2,
        buttonLayout: 'horizontal',
        closeIcon: false,
        showInput: false,
        inputValue: '',
        inputPlaceholder: '请输入家庭名称'
      },
      buttonRows: [
        { key: 'p-d', label: 'Primary / Default', variant: 'primary', state: 'default', text: '按钮文案' },
        { key: 'p-p', label: 'Primary / Pressed', variant: 'primary', state: 'pressed', text: '按钮文案' },
        { key: 'p-dis', label: 'Primary / Disabled', variant: 'primary', state: 'disabled', text: '按钮文案' },
        { key: 'p-l', label: 'Primary / Loading', variant: 'primary', state: 'loading', text: '按钮文案' },
        { key: 's-d', label: 'Secondary / Default', variant: 'secondary', state: 'default', text: '按钮文案' },
        { key: 's-p', label: 'Secondary / Pressed', variant: 'secondary', state: 'pressed', text: '按钮文案' },
        { key: 's-dis', label: 'Secondary / Disabled', variant: 'secondary', state: 'disabled', text: '按钮文案' },
        { key: 's-w', label: 'Secondary / Warning', variant: 'secondary', state: 'warning', text: '按钮文案' }
      ],
      textRows: [
        { key: 't-d', label: 'Default', state: 'default', value: '', placeholder: 'Dreame X50' },
        { key: 't-f', label: 'Focus', state: 'focus', value: 'Dreame X50', placeholder: '请输入' },
        { key: 't-fill', label: 'Filled', state: 'filled', value: 'Dreame X50', placeholder: '请输入' },
        { key: 't-e', label: 'Error', state: 'error', value: 'Dreame X50', placeholder: '请输入' },
        { key: 't-dis', label: 'Disabled', state: 'disabled', value: 'Dreame X50', placeholder: '请输入' }
      ],
      passwordRows: [
        { key: 'pw-h', label: 'Filled / Hidden', state: 'filled', visible: false, value: '12312312312231' },
        { key: 'pw-v', label: 'Filled / Visible', state: 'filled', visible: true, value: '12312312312231' },
        { key: 'pw-e', label: 'Empty', state: 'empty', visible: true, value: '' },
        { key: 'pw-f', label: 'Focus', state: 'focus', visible: false, value: '12312312312231' },
        { key: 'pw-err', label: 'Error', state: 'error', visible: false, value: '12312312312231' },
        { key: 'pw-d', label: 'Disabled', state: 'disabled', visible: false, value: '12312312312231' }
      ],
      otpRows: [
        { key: 'o-f', label: 'Filled', state: 'filled', value: '888888' },
        { key: 'o-e', label: 'Empty', state: 'empty', value: '' },
        { key: 'o-err', label: 'Error', state: 'error', value: '888888' },
        { key: 'o-d', label: 'Disabled', state: 'disabled', value: '888888' }
      ],
      selectRows: [
        { key: 's-sel', label: 'Selected', state: 'selected', value: '小猪仔的家庭', placeholder: '请选择', hint: '' },
        { key: 's-d', label: 'Default', state: 'default', value: '', placeholder: '小猪仔的家庭', hint: '' },
        { key: 's-dis', label: 'Disabled', state: 'disabled', value: '小猪仔的家庭', placeholder: '请选择', hint: '' },
        {
          key: 's-e',
          label: 'Error',
          state: 'error',
          value: '小猪仔的家庭',
          placeholder: '请选择',
          hint: '检测到您的wifi存在风险，请更换wifi配网'
        }
      ],
      dialogRows: (function () {
        const body = '这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本'
        const sheet =
          '这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本是一些文本这是一些文本是一些文本这是一些文本是一些文本这是一些文本'
        const row = (key, label, extra) =>
          Object.assign(
            {
              key,
              label,
              type: 'standard',
              placement: 'center',
              title: '弹窗标题',
              content: body,
              actions: 2,
              buttonLayout: 'horizontal',
              closeIcon: false,
              warning: false,
              showInput: false,
              inputPlaceholder: '请输入'
            },
            extra
          )
        return [
          row('1811-9673', 'Center · 双按钮'),
          row('1811-9739', 'Center · 单按钮', { actions: 1 }),
          row('1811-9829', 'Bottom · 单按钮', { placement: 'bottom', actions: 1, content: sheet }),
          row('1811-9862', 'Bottom · 双按钮', { placement: 'bottom', content: sheet }),
          row('1811-9882', 'Bottom · 纵向 1', {
            placement: 'bottom',
            buttonLayout: 'vertical-style-1',
            content: sheet
          }),
          row('1811-9901', 'Bottom · 纵向 2', {
            placement: 'bottom',
            buttonLayout: 'vertical-style-2',
            content: sheet
          }),
          row('1811-9715', 'Center · 双按钮 · 关闭', { closeIcon: true }),
          row('1811-9820', 'Center · 单按钮 · 关闭', { actions: 1, closeIcon: true }),
          row('1811-9845', 'Bottom · 单按钮 · 关闭', {
            placement: 'bottom',
            actions: 1,
            closeIcon: true,
            content: sheet
          }),
          row('1811-9958', 'Bottom · 双按钮 · 关闭', {
            placement: 'bottom',
            closeIcon: true,
            content: sheet
          }),
          row('1811-9920', 'Bottom · 纵向 1 · 关闭', {
            placement: 'bottom',
            buttonLayout: 'vertical-style-1',
            closeIcon: true,
            content: sheet
          }),
          row('1811-9939', 'Bottom · 纵向 2 · 关闭', {
            placement: 'bottom',
            buttonLayout: 'vertical-style-2',
            closeIcon: true,
            content: sheet
          }),
          row('1811-9695', 'Center · 无标题', { title: '' }),
          row('1811-9747', 'Center · 无标题 · 单按钮', { title: '', actions: 1 }),
          row('1811-9798', 'Center · 无标题 · 纵向 1', {
            title: '',
            actions: 1,
            buttonLayout: 'vertical-style-1'
          }),
          row('1811-9776', 'Center · 无标题 · 纵向 2', {
            title: '',
            actions: 1,
            buttonLayout: 'vertical-style-2'
          }),
          row('1811-9808', 'Center · 纵向 1 · 关闭', {
            actions: 1,
            buttonLayout: 'vertical-style-1',
            closeIcon: true
          }),
          row('1811-9765', 'Center · 纵向 2', { actions: 1, buttonLayout: 'vertical-style-2' }),
          row('1811-9786', 'Center · 纵向 2 · 关闭', {
            actions: 1,
            buttonLayout: 'vertical-style-2',
            closeIcon: true
          }),
          row('1811-9684', 'Light · 双按钮', { type: 'light' }),
          row('1811-9705', 'Light · 无标题', { type: 'light', title: '' }),
          row('1811-9727', 'Light · 关闭', { type: 'light', closeIcon: true }),
          row('1811-9754', 'Center · 纵向 1', { actions: 1, buttonLayout: 'vertical-style-1' }),
          row('2075-907', 'Center · 带输入', {
            title: '修改家庭名称',
            content: '',
            showInput: true,
            inputPlaceholder: '请输入家庭名称'
          }),
          row('2082-1084', 'Light · Warning', { type: 'light', title: '', warning: true })
        ]
      })(),
      toastRows: [
        { key: 't-msg', label: 'Default', message: 'Message text' },
        { key: 't-share', label: '分享反馈', message: '对方已接受分享' },
        {
          key: 't-long',
          label: '长文案',
          message: '这是一条稍长的提示，宽度最多 354，超出换行'
        }
      ]
    }
  },
  watch: {
    dark: {
      immediate: true,
      handler(val) {
        if (typeof document === 'undefined') return
        document.documentElement.classList.toggle('theme-dark', !!val)
        const page = document.querySelector('uni-page-body')
        if (page) page.classList.toggle('theme-dark', !!val)
      }
    }
  },
  methods: {
    ping(name) {
      uni.showToast({ title: name, icon: 'none' })
    },
    openDialog(kind) {
      const base = {
        show: true,
        type: 'standard',
        placement: 'center',
        title: '弹窗标题',
        content: '这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本这是一些文本',
        actions: 2,
        buttonLayout: 'horizontal',
        closeIcon: false,
        showInput: false,
        inputValue: '',
        inputPlaceholder: '请输入家庭名称'
      }
      if (kind === 'one') base.actions = 1
      if (kind === 'sheet') base.placement = 'bottom'
      if (kind === 'input') {
        base.title = '修改家庭名称'
        base.content = ''
        base.showInput = true
      }
      this.liveDialog = base
    },
    closeDialog() {
      this.liveDialog.show = false
    },
    openToast(position) {
      const message = position === 'center' ? 'Message text' : '对方已接受分享'
      const next = { show: true, message, position }
      if (this.liveToast.show) {
        this.liveToast.show = false
        this.$nextTick(() => {
          this.liveToast = next
        })
        return
      }
      this.liveToast = next
    },
    cycleStep(total) {
      if (total === 3) {
        this.stepThree = this.stepThree >= 3 ? 1 : this.stepThree + 1
        return
      }
      this.stepFive = this.stepFive >= 5 ? 1 : this.stepFive + 1
    }
  }
}
</script>

<style lang="scss">
.shell {
  display: flex;
  flex-direction: row;
  align-items: stretch;
  min-height: 100vh;
  background: var(--dreame-background-page);
}

.side {
  box-sizing: border-box;
  width: 168px;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  padding: 24px 16px;
  background: var(--dreame-background-card);
  border-right: 1px solid var(--dreame-divider-subtle);
}

.side__name {
  display: block;
  margin-bottom: 20px;
  font-size: 13px;
  font-weight: 600;
  letter-spacing: 0.04em;
  color: var(--dreame-brand-default);
}

.side__item {
  display: flex;
  align-items: center;
  height: 40px;
  padding: 0 12px;
  margin-bottom: 4px;
  border-radius: 8px;
}

.side__label {
  font-size: 15px;
  color: var(--dreame-text-secondary);
}

.side__item.is-on {
  background: var(--dreame-background-brandsubtle);
}

.side__item.is-on .side__label {
  color: var(--dreame-brand-default);
  font-weight: 600;
}

.side__theme {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  margin-top: auto;
  padding: 16px 12px 0;
}

.side__theme-label {
  font-size: 13px;
  color: var(--dreame-text-tertiary);
}

.main {
  flex: 1;
  min-width: 0;
  padding: 28px 32px 80px;
  box-sizing: border-box;
}

.page__name {
  display: block;
  margin-bottom: 24px;
  font-size: 20px;
  font-weight: 600;
  color: var(--dreame-text-primary);
}

.h {
  display: block;
  margin: 8px 0 12px;
  font-size: 13px;
  font-weight: 600;
  color: var(--dreame-text-tertiary);
}

.code {
  background: var(--dreame-background-card);
  border-radius: 12px;
  padding: 16px 18px;
  margin-bottom: 20px;
}

.code__snip,
.code__meta {
  display: block;
  font-size: 13px;
  line-height: 22px;
}

.code__snip {
  font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
  color: var(--dreame-brand-default);
}

.code__meta {
  margin-top: 8px;
  color: var(--dreame-text-tertiary);
}

.demo {
  margin-bottom: 36px;
}

.demo__cap {
  display: block;
  margin: 4px 0 8px;
  font-size: 12px;
  color: var(--dreame-text-tertiary);
}

.demo__space {
  height: 12px;
}

.spec {
  margin-bottom: 24px;
}

.spec__label {
  display: block;
  margin-bottom: 10px;
  font-size: 12px;
  color: var(--dreame-text-tertiary);
}

.spec__btns {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  align-items: center;
}

.spec__gap {
  width: 16px;
  height: 1px;
}

.spec--dialog {
  align-items: flex-start;
}

.dialog-grid {
  display: grid !important;
  grid-template-columns: repeat(auto-fill, 241px);
  gap: 32px 24px;
  width: 100%;
  align-items: start;
}

.dialog-cell {
  width: 241px;
  max-width: 100%;
  flex: none;
}

.dialog-cell__label {
  display: block;
  margin-bottom: 12px;
  font-size: 12px;
  color: var(--dreame-text-tertiary);
}

.step-grid {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  gap: 24px 16px;
  margin-bottom: 28px;
}

.step-cell {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.step-cell__label {
  display: block;
  margin-bottom: 10px;
  font-size: 12px;
  color: var(--dreame-text-tertiary);
}

@media (max-width: 720px) {
  .shell {
    flex-direction: column;
  }

  .side {
    width: 100%;
    display: flex;
    flex-direction: row;
    align-items: center;
    border-right: none;
    border-bottom: 1px solid var(--dreame-divider-subtle);
    padding: 12px 16px;
  }

  .side__name {
    margin: 0 16px 0 0;
  }

  .side__item {
    margin: 0 4px 0 0;
  }

  .main {
    padding: 20px 20px 80px;
  }
}

@media (min-width: 900px) {
  .main {
    padding: 32px 48px 80px;
  }

  .spec {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
    margin-bottom: 20px;
  }

  .spec__label {
    width: 168px;
    margin-bottom: 0;
    margin-right: 16px;
    text-align: right;
    flex-shrink: 0;
    padding-top: 16px;
  }

  .spec__btns {
    flex-wrap: nowrap;
  }
}
</style>
