

import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/utils/colors.dart';

import '../utils/styles.dart';

enum StateRendererType {
  // POPUP STATES (DIALOG)
  popupLoadingState,
  popupErrorState,
  popupSuccess,
  // FULL SCREEN STATES (FULL SCREEN)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  // general
  contentState,
  snackbarState  // NEW STATE FOR SNACKBAR
}

// ignore: must_be_immutable
class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer({
    super.key,
    required this.stateRendererType,
    this.message = '',
    this.title = "",
    required this.retryActionFunction
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopUpDialog(
            context, [_getAnimatedImage('assets/json/loading.json')]);
      case StateRendererType.popupErrorState:
        return _getPopUpDialog(context, [
          _getAnimatedImage('assets/json/error.json'),
          _getMessage(message),
          _getRetryButton('OK', context)
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn(
            [
              _getAnimatedImage('assets/json/loading.json'),
              _getMessage(message)
            ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage('assets/json/error.json'),
          _getMessage(message),
          _getRetryButton('Try Again', context)
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn(
            [
              _getAnimatedImage('assets/json/empty.json'),
              _getMessage(message)
            ]);
      case StateRendererType.contentState:
        return const SizedBox();
      case StateRendererType.popupSuccess:
        return _getPopUpDialog(context, [
          _getAnimatedImage('assets/json/success.json'),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton('OK', context)
        ]);
      case StateRendererType.snackbarState: // HANDLE SNACKBAR STATE
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () => retryActionFunction.call(),
            ),
          ));
        });
        return const SizedBox(); // Return empty widget as Snackbar is displayed separately
      default:
        return const SizedBox();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return const SizedBox(
        height: 50,
        width: 50,
        child : CircularProgressIndicator(color: AppColors.primary,) ) ;
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          message,
          style: robotoBold.copyWith(color: AppColors.primary) ,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  retryActionFunction.call();
                },
                child: Text(
                  buttonTitle,
                  style: robotoBold.copyWith(color: AppColors.primary)
                )
            )
        ),
      ),
    );
  }
}