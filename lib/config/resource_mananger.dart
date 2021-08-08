import 'dart:math';

import 'package:demo_getx/net/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 作者：Mengcy
/// 时间：2020/5/17 15:35
/// 描述：图片工具类
class ImageHelper {
  ///网络图
  static String wrapUrl(String? url) {
    if (url == null) {
      return "";
    }
    if (url.startsWith('http')) {
      return url;
    }
    return HttpManager.URL_IMAGE + url;
  }

  ///本地图
  static String wrapAssets(String url) {
    return "assets/images/" + url;
  }

  static Widget placeHolder({double width = 0, double height = 0}) {
    return SizedBox(
        width: width,
        height: height,
        child: CupertinoActivityIndicator(radius: min(10.0, width / 3)));
  }

  static Widget error({double width = 0, double height = 0, double size = 0}) {
    return SizedBox(
        width: width,
        height: height,
        child: Icon(
          Icons.error_outline,
          size: size,
        ));
  }
}

class IconFonts {
  IconFonts._();

  /// iconfont:字体图标
  static const String fontFamily = 'iconfont';

  static const IconData pageEmpty = IconData(0xe604, fontFamily: fontFamily);
  static const IconData pageError = IconData(0xe6f0, fontFamily: fontFamily);
  static const IconData pageNetworkError =
      IconData(0xe614, fontFamily: fontFamily);
  static const IconData pageUnAuth = IconData(0xe634, fontFamily: fontFamily);
}
