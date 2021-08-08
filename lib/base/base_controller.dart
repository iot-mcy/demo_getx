import 'package:get/get.dart';

import 'base_state.dart';

abstract class BaseController<T extends BaseState> extends GetxController {
  late T _viewState;

  void setViewState(T state) {
    _viewState = state;
  }

  void setIdle(List<Object> ids) {
    _viewState.setIdle();
    update(ids);
  }

  void setLoading(List<Object> ids) {
    _viewState.setLoading();
    update(ids);
  }

  void setEmpty(List<Object> ids) {
    _viewState.setEmpty();
    update(ids);
  }

  void setError(List<Object> ids, e, stackTrace, {String? message}) {
    _viewState.setError(e, stackTrace, message: message);
    update(ids);
  }
}
