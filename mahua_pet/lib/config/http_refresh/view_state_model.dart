
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mahua_pet/component/component.dart';
import 'view_state.dart';
import 'http_base.dart';


class ViewStateModel extends ChangeNotifier {

  /// 根据状态构造
  /// 子类可以在构造函数指定需要的页面状态
  ViewStateModel({ViewState viewState}): _viewState = viewState ?? ViewState.idle {
    // debugPrint('ViewStateModel---constructor--->$runtimeType');
  }
  
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// ViewStateError
  ViewStateError _viewStateError;
  ViewStateError get viewStateError => _viewStateError;


  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState;

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
    notifyListeners();
  }


  /// get
  bool get isBusy => viewState == ViewState.busy;

  bool get isIdle => viewState == ViewState.idle;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;


  /// set
  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  /// [e]分类Error和Exception两种
  void setError(e, stackTrace, {String message}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;

    if (e is DioError) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT || 
          e.type == DioErrorType.SEND_TIMEOUT || 
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorType = ViewStateErrorType.networkTimeOutError;
        message = e.error;
      } else if (e.type == DioErrorType.RESPONSE ||
          e.type == DioErrorType.CANCEL) {
        message = e.error;
      } else {
        e = e.error;
        if (e is UnAuthorizedException) {
          stackTrace = null;
          errorType = ViewStateErrorType.unauthorizedError;
        } else if (e is NotSuccessException) {
          errorType = ViewStateErrorType.networkTimeOutError;
          message = e.message;
        } else {
          message = e.message;
        }
      }
    }

    viewState = ViewState.error;
    _viewStateError = ViewStateError(errorType, message: message, errorMessage: e.toString());
    printErrorStack(e, stackTrace);
    onError(_viewStateError);
  }

  void onError(ViewStateError viewStateError) {}

  /// 显示错误消息
  showErrorMessage(context, {String message}) {
    if (viewStateError != null || message != null) {
      if (viewStateError.isNetworkTimeOut) {
        message ??= '';
      } else {
        message ??= viewStateError.message;
      }
      TKToast.showError(message);
    }
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _viewStateError: $_viewStateError}';
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}



/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
  debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----error-----↓↓↓↓↓↓↓↓↓↓----->
$e
<-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑----->''');
  if (s != null) debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----trace-----↓↓↓↓↓↓↓↓↓↓----->
$s
<-----↑↑↑↑↑↑↑↑↑↑-----trace-----↑↑↑↑↑↑↑↑↑↑----->
    ''');
}
