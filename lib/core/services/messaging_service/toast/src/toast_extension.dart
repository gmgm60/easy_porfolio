import 'package:easy_porfolio/core/services/messaging_service/toast/src/toast_list_overlay.dart';
import 'package:easy_porfolio/core/services/messaging_service/toast/toast_model.dart';
import 'package:flutter/material.dart';

extension ToastListExtension on BuildContext {
  void showToast(ToastModel text) {
    ToastListOverlay.of<ToastModel>(this).show(this, text);
  }

  void hideToast(
    ToastModel item,
    Widget Function(BuildContext, Animation<double>) builder,
  ) {
    ToastListOverlay.of<ToastModel>(this).removeItem(item, builder);
  }
}
