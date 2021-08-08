import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// 页面状态类型
enum ViewState {
  idle, // 加载完成
  loading, // 加载中
  empty, // 无数据
  error, // 加载失败
}

/// 错误类型
enum ViewStateErrorType {
  defaultError,
  networkTimeOutError, //网络错误
  unauthorizedError //为授权(一般为未登录)
}

class ViewStateError {
  ViewStateErrorType _errorType;
  String? message;
  String? errorMessage;

  ViewStateError(this._errorType, {this.message, this.errorMessage}) {
    message ??= errorMessage;
  }

  ViewStateErrorType get errorType => _errorType;

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  bool get isDefaultError => _errorType == ViewStateErrorType.defaultError;

  bool get isNetworkTimeOut =>
      _errorType == ViewStateErrorType.networkTimeOutError;

  bool get isUnauthorized => _errorType == ViewStateErrorType.unauthorizedError;

  @override
  String toString() {
    return 'ViewStateError{errorType: $_errorType, message: $message, errorMessage: $errorMessage}';
  }
}

/// 作者 mcy
/// 时间 2021/7/27 10:14
///
class BaseState {
  BaseState({ViewState? viewState}) : _viewState = viewState ?? ViewState.idle {
    //
  }

  /// 当前的页面状态,默认为idle,可在viewModel的构造方法中指定;
  ViewState _viewState;

  /// ViewState
  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
  }

  /// ViewStateError
  ViewStateError? _viewStateError;

  ViewStateError? get viewStateError => _viewStateError;

  bool get isLoading => viewState == ViewState.loading;

  bool get isIdle => viewState == ViewState.idle;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;

  void setIdle() {
    viewState = ViewState.idle;
  }

  void setLoading() {
    viewState = ViewState.loading;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  /// [e]分类Error和Exception两种
  void setError(e, stackTrace, {String? message}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;

    /// 见https://github.com/flutterchina/dio/blob/master/README-ZH.md#dioerrortype
    if (e is DioError) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        // timeout
        errorType = ViewStateErrorType.networkTimeOutError;
        message = e.error;
      } else if (e.type == DioErrorType.response) {
        // incorrect status, such as 404, 503...
        message = e.error;
      } else if (e.type == DioErrorType.cancel) {
        // to be continue...
        message = e.error;
      } else {
        // dio将原error重新套了一层
        e = e.error;
        if (e is SocketException) {
          errorType = ViewStateErrorType.networkTimeOutError;
          message = e.message;
        } else {
          message = e.message;
        }
      }
    }
    viewState = ViewState.error;
    _viewStateError = ViewStateError(
      errorType,
      message: message,
      errorMessage: e.toString(),
    );
    printErrorStack(e, stackTrace);
    onError(viewStateError);
  }

  void onError(ViewStateError? viewStateError) {}

  /// [e]为错误类型 :可能为 Error , Exception ,String
  /// [s]为堆栈信息
  printErrorStack(e, s) {
    debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----error-----↓↓↓↓↓↓↓↓↓↓----->
$e
<-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑----->''');
  }
}
