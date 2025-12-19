import 'package:easy_porfolio/core/services/messaging_service/toast/src/src.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToastModel {
  String message;
  ToastType type;

  ToastModel(this.message, this.type);
}

enum ToastType { success, failed, warning, info }

class ToastItem extends StatelessWidget {
  const ToastItem({
    super.key,
    this.onTap,
    required this.animation,
    required this.item,
  });

  final Animation<double> animation;
  final VoidCallback? onTap;
  final ToastModel item;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(
      context,
    ).textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 14);

    return Container(
      margin: const EdgeInsets.all(15.0),
      child: FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: Container(
            decoration: BoxDecoration(
              color: _getTypeColor(item.type),
              borderRadius:context.radiusTokens.all10,
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.type == ToastType.failed
                      ? CupertinoIcons.exclamationmark_circle_fill
                      : CupertinoIcons.checkmark_circle_fill,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.message,
                    style: textStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  constraints: const BoxConstraints(
                    maxWidth: 30,
                    maxHeight: 30,
                  ),
                  iconSize: 15,
                  icon: const Icon(CupertinoIcons.clear, color: Colors.white),
                  onPressed: () => onTap?.call(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return Colors.green;
      case ToastType.warning:
        return Colors.amber;
      case ToastType.info:
        return Colors.blue;
      case ToastType.failed:
        return Colors.red;
    }
  }
}

Widget buildToastItem(
  BuildContext context,
  ToastModel item,
  int index,
  Animation<double> animation,
) {
  return ToastItem(
    animation: animation,
    item: item,
    onTap: () => context.hideToast(
      item,
      (context, animation) => buildToastItem(context, item, index, animation),
    ),
  );
}
