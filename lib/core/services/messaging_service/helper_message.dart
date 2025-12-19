import 'package:easy_porfolio/core/services/messaging_service/toast/src/src.dart';
import 'package:easy_porfolio/core/services/messaging_service/toast/toast_model.dart';
import 'package:flutter/material.dart';

class ToastMessage {
  ToastMessage.success({
    required String message,
    required BuildContext ctx,
  }) {
    ctx.showToast(ToastModel(message, ToastType.success));
  }

  ToastMessage.warning({
    required String message,
    required BuildContext ctx,
  }) {
    ctx.showToast(ToastModel(message, ToastType.warning));
  }

  ToastMessage.failed({
    required String message,
    required BuildContext ctx,
  }) {
    ctx.showToast(ToastModel(message, ToastType.failed));
  }
}