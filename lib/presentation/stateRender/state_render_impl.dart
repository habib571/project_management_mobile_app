import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:lottie/lottie.dart';
import 'package:project_management_app/presentation/stateRender/state_render.dart';

import '../../application/constants/constants.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}
// loading state (POPUP,FULL SCREEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState({required this.stateRendererType, String message = "loading.."});

  @override
  String getMessage() => message ?? "loading";

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class SnackbarState extends FlowState {
  String message;

  SnackbarState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.snackbarState;
}

// error state (POPUP,FULL SCREEN)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => "";

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// EMPTY STATE

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

// success state
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccess;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function() retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          dismissOverlay(context);
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            // show popup loading

            showPopup(context, getStateRendererType(), getMessage());

            return contentScreenWidget;
          } else if (getStateRendererType() ==
              StateRendererType.overlayLoadingState) {
            Loader.show(
              context,
              progressIndicator: SizedBox(
                  height: 70,
                  width: 70,
                  child: Lottie.asset("assets/overlay.json")),
            );
            return contentScreenWidget;
          } else {
            // full screen loading state
            return StateRenderer(
                message: getMessage(),
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ErrorState:
        {
          dismissOverlay(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            // show popup error
            showPopup(context, getStateRendererType(), getMessage());
            // show content ui of the screen
            return contentScreenWidget;
          } else if (getStateRendererType() ==
              StateRendererType.snackbarState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor:
                      Colors.transparent, // Set transparent to customize
                  elevation: 0,
                  content: Container(
                    height: 100,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red, // Background color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Error', // Title text
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          getMessage(), // Error message text
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  action: SnackBarAction(
                    label: 'Retry',
                    textColor: Colors.white,
                    onPressed: retryActionFunction,
                  ),
                ),
              );
            });
            return contentScreenWidget;
          } else {
            // full screen error state
            return StateRenderer(
                message: getMessage(),
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case EmptyState _:
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: () {});
        }
      case ContentState _:
        {
          // dismissDialog(context);

          return contentScreenWidget;
        }
      case SuccessState _:
        {
          // i should check if we are showing loading popup to remove it before showing success popup
          dismissOverlay(context);
          // show popup
          showPopup(context, StateRendererType.popupSuccess, getMessage(),
              title: 'Success');
          // return content ui of the screen
          return contentScreenWidget;
        }
      default:
        {
          //dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  void dismissOverlay(BuildContext context) {
    if (Loader.isShown) {
      Loader.hide();
    }
  }

  showPopup(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = ""}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            title: title,
            retryActionFunction: () {})));
  }
}
