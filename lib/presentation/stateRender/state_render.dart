

import 'package:flutter/material.dart';
import 'package:project_management_app/application/extensions/screen_config_extension.dart';
import 'package:project_management_app/presentation/sharedwidgets/custom_button.dart';
import 'package:project_management_app/presentation/utils/colors.dart';

import '../utils/styles.dart';

enum StateRendererType {
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  contentState,
  snackBarState
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
      case StateRendererType.snackBarState: // HANDLE SNACKBAR STATE
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



  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return const SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(color: AppColors.primary,)
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          message,
          style: robotoRegular.copyWith(fontSize: 17) ,
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
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.w) ,
                 child: CustomButton(onPressed: () {
                   retryActionFunction.call() ;
                 }, text: buttonTitle
                 ),
            )
        ),
      ),
    );
  }
}