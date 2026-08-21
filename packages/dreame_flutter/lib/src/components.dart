import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme.dart';

enum DreameButtonVariant { primary, secondary }

enum DreameButtonSize { small, medium, large }

class DreameButton extends StatelessWidget {
  const DreameButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = DreameButtonVariant.primary,
    this.size = DreameButtonSize.large,
    this.loading = false,
    this.warning = false,
  });
  final String text;
  final VoidCallback? onPressed;
  final DreameButtonVariant variant;
  final DreameButtonSize size;
  final bool loading, warning;

  @override
  Widget build(BuildContext context) {
    final c = context.dreameColors;
    final enabled = onPressed != null && !loading;
    final d = switch (size) {
      DreameButtonSize.small => (104.0, 36.0, 14.0),
      DreameButtonSize.medium => (160.0, 43.0, 16.0),
      DreameButtonSize.large => (335.0, 48.0, 16.0),
    };
    final primary = variant == DreameButtonVariant.primary;
    Color background(Set<WidgetState> states) {
      if (!enabled) return primary ? c.brandDisabled : c.inputDisabled;
      if (states.contains(WidgetState.pressed)) {
        return primary ? c.brandPressed : c.inputDisabled;
      }
      return primary ? c.brandSurface : c.card;
    }

    return SizedBox(
      width: d.$1,
      height: d.$2,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 24),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
              side: primary ? BorderSide.none : BorderSide(color: c.border),
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith(background),
          foregroundColor: WidgetStatePropertyAll(
            !enabled
                ? c.textDisabled
                : (warning
                    ? c.error
                    : primary
                        ? c.brandText
                        : c.textPrimary),
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: d.$3, fontWeight: FontWeight.w500),
          ),
        ),
        child: loading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: c.brandText,
                ),
              )
            : Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

class DreameInput extends StatelessWidget {
  const DreameInput({
    super.key,
    this.controller,
    this.initialValue,
    this.placeholder = '请输入',
    this.enabled = true,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
  });
  final TextEditingController? controller;
  final String? initialValue, errorText;
  final String placeholder;
  final bool enabled, obscureText, readOnly;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    final c = context.dreameColors;
    OutlineInputBorder border(Color color) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color),
        );
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      style: TextStyle(color: c.textPrimary, fontSize: 16),
      decoration: InputDecoration(
        hintText: placeholder,
        errorText: errorText,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: enabled ? c.card : c.inputDisabled,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: TextStyle(color: c.textTertiary, fontSize: 16),
        enabledBorder: border(c.border),
        focusedBorder: border(c.borderFocus),
        errorBorder: border(c.error),
        focusedErrorBorder: border(c.error),
        disabledBorder: border(c.inputDisabled),
      ),
    );
  }
}

class DreamePasswordInput extends StatefulWidget {
  const DreamePasswordInput({
    super.key,
    this.controller,
    this.placeholder = '请输入密码',
    this.enabled = true,
    this.errorText,
    this.onChanged,
  });
  final TextEditingController? controller;
  final String placeholder;
  final bool enabled;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  @override
  State<DreamePasswordInput> createState() => _DreamePasswordInputState();
}

class _DreamePasswordInputState extends State<DreamePasswordInput> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) => DreameInput(
        controller: widget.controller,
        placeholder: widget.placeholder,
        enabled: widget.enabled,
        errorText: widget.errorText,
        onChanged: widget.onChanged,
        obscureText: obscure,
        suffixIcon: IconButton(
          onPressed:
              widget.enabled ? () => setState(() => obscure = !obscure) : null,
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          ),
        ),
      );
}

class DreameSelectInput extends StatelessWidget {
  const DreameSelectInput({
    super.key,
    this.value,
    this.placeholder = '请选择',
    this.enabled = true,
    this.errorText,
    this.onTap,
  });
  final String? value, errorText;
  final String placeholder;
  final bool enabled;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => DreameInput(
        initialValue: value,
        placeholder: placeholder,
        enabled: enabled,
        errorText: errorText,
        readOnly: true,
        onTap: enabled ? onTap : null,
        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      );
}

class DreameOtpInput extends StatefulWidget {
  const DreameOtpInput({
    super.key,
    this.controller,
    this.length = 6,
    this.enabled = true,
    this.error = false,
    this.onChanged,
  });
  final TextEditingController? controller;
  final int length;
  final bool enabled, error;
  final ValueChanged<String>? onChanged;
  @override
  State<DreameOtpInput> createState() => _DreameOtpInputState();
}

class _DreameOtpInputState extends State<DreameOtpInput> {
  late final TextEditingController internal;
  TextEditingController get controller => widget.controller ?? internal;
  @override
  void initState() {
    super.initState();
    internal = TextEditingController();
    controller.addListener(refresh);
  }

  @override
  void didUpdateWidget(covariant DreameOtpInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      (oldWidget.controller ?? internal).removeListener(refresh);
      controller.addListener(refresh);
    }
  }

  @override
  void dispose() {
    controller.removeListener(refresh);
    internal.dispose();
    super.dispose();
  }

  void refresh() => setState(() {});
  @override
  Widget build(BuildContext context) {
    final c = context.dreameColors, value = controller.text;
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.length, (i) {
            final active = i == value.length && widget.enabled;
            final color = widget.error
                ? c.error
                : active
                    ? c.borderFocus
                    : c.border;
            return Padding(
              padding: EdgeInsets.only(right: i == widget.length - 1 ? 0 : 8),
              child: Container(
                width: 48,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.enabled ? c.card : c.inputDisabled,
                  border: Border.all(color: color),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  i < value.length ? value[i] : '',
                  style: TextStyle(
                    color: c.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 0.01,
            child: TextField(
              controller: controller,
              enabled: widget.enabled,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.length),
              ],
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class DreameStepIndicator extends StatelessWidget {
  const DreameStepIndicator({super.key, this.steps = 5, this.current = 1});
  final int steps, current;
  @override
  Widget build(BuildContext context) {
    final c = context.dreameColors,
        count = steps == 3 ? 3 : 5,
        index = current.clamp(1, steps == 3 ? 3 : 5);
    return SizedBox(
      width: count == 5 ? 113 : 67,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            count == 5 ? '$index / $count' : '$index',
            style: TextStyle(
              color: count == 3 && index > 1 ? c.textTertiary : c.brand,
              fontSize: count == 5 ? 16 : 18,
              fontWeight: count == 5 ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              count,
              (bar) => Expanded(
                child: Container(
                  height: 2,
                  margin: EdgeInsets.only(right: bar == count - 1 ? 0 : 2),
                  decoration: BoxDecoration(
                    color: bar < index ? c.brand : c.textDisabled,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum DreameToastPosition { bottom, center }

class DreameToast {
  const DreameToast._();
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    required String message,
    DreameToastPosition position = DreameToastPosition.bottom,
    Duration duration = const Duration(seconds: 2),
  }) {
    final c = context.dreameColors, messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    return messenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: c.textPrimary, fontSize: 14),
        ),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: c.elevated,
        margin: position == DreameToastPosition.center
            ? EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.sizeOf(context).height * .42,
              )
            : const EdgeInsets.fromLTRB(20, 0, 20, 34),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
    );
  }
}

enum DreameDialogPlacement { center, bottom }

enum DreameDialogButtonLayout {
  horizontal,
  verticalPrimaryFirst,
  verticalSecondaryFirst,
}

class DreameDialog extends StatelessWidget {
  const DreameDialog({
    super.key,
    this.title,
    this.content,
    this.confirmText = '确定',
    this.cancelText = '取消',
    this.onConfirm,
    this.onCancel,
    this.actions = 2,
    this.buttonLayout = DreameDialogButtonLayout.horizontal,
    this.closeIcon = false,
    this.warning = false,
    this.inputController,
    this.inputPlaceholder = '请输入',
  });
  final String? title, content;
  final String confirmText, cancelText, inputPlaceholder;
  final VoidCallback? onConfirm, onCancel;
  final int actions;
  final DreameDialogButtonLayout buttonLayout;
  final bool closeIcon, warning;
  final TextEditingController? inputController;
  static Future<T?> show<T>(
    BuildContext context, {
    DreameDialogPlacement placement = DreameDialogPlacement.center,
    required DreameDialog dialog,
  }) {
    if (placement == DreameDialogPlacement.bottom) {
      return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: context.dreameColors.backdrop,
        builder: (_) => SafeArea(top: false, child: dialog),
      );
    }
    return showDialog<T>(
      context: context,
      barrierColor: context.dreameColors.backdrop,
      builder: (_) => Center(child: dialog),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.dreameColors;
    final confirm = DreameButton(
      text: confirmText,
      size: DreameButtonSize.medium,
      warning: warning,
      onPressed: onConfirm ?? () => Navigator.maybePop(context),
    );
    final cancel = DreameButton(
      text: cancelText,
      size: DreameButtonSize.medium,
      variant: DreameButtonVariant.secondary,
      onPressed: onCancel ?? () => Navigator.maybePop(context),
    );
    final vertical = buttonLayout != DreameDialogButtonLayout.horizontal;
    final buttons = actions == 1
        ? <Widget>[confirm]
        : buttonLayout == DreameDialogButtonLayout.verticalSecondaryFirst
            ? <Widget>[cancel, confirm]
            : <Widget>[confirm, cancel];
    return Material(
      color: c.elevated,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 335),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (closeIcon)
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.close),
                  ),
                ),
              if (title?.isNotEmpty ?? false)
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: c.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (content?.isNotEmpty ?? false) ...[
                const SizedBox(height: 12),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      content!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: c.textSecondary,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
              if (inputController != null) ...[
                const SizedBox(height: 16),
                DreameInput(
                  controller: inputController,
                  placeholder: inputPlaceholder,
                ),
              ],
              const SizedBox(height: 24),
              if (vertical)
                Column(
                  children: [
                    for (var i = 0; i < buttons.length; i++) ...[
                      buttons[i],
                      if (i < buttons.length - 1) const SizedBox(height: 12),
                    ],
                  ],
                )
              else
                Row(
                  children: [
                    for (var i = 0; i < buttons.length; i++) ...[
                      Expanded(child: buttons[i]),
                      if (i < buttons.length - 1) const SizedBox(width: 12),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
