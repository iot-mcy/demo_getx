import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

///中间件（登录）
class RouteAuthMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    ///todo 判断用户是否已经登录
    if (false) {
      return null;
    } else {
      Future.delayed(Duration(seconds: 1), () {
        Get.snackbar("提示", "请先登录");
      });
      return RouteSettings(name: Routes.PAGE_AUTH);
    }
  }
}
