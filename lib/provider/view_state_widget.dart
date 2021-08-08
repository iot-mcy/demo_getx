import 'package:demo_getx/base/base_state.dart';
import 'package:demo_getx/config/resource_mananger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

/// 加载中
class ViewStateLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

/// 基础Widget
class ViewStateWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback? onPressed;

  ViewStateWidget(
      {Key? key,
      this.image,
      this.title,
      this.message,
      this.buttonText,
      @required this.onPressed,
      this.buttonTextData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context)
        .textTheme
        .subtitle1
        ?.copyWith(color: Colors.grey, fontSize: 14);
    var messageStyle = titleStyle?.copyWith(
        color: titleStyle.color?.withOpacity(0.7), fontSize: 12);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        image ?? Icon(IconFonts.pageError, size: 56, color: Colors.grey[500]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title ?? "加载失败",
                style: titleStyle,
              ),
              SizedBox(height: 20),
              Offstage(
                offstage: isEmpty(message) ? true : false,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 200, minHeight: 150),
                  child: SingleChildScrollView(
                    child: Text(message ?? '', style: messageStyle),
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: ViewStateButton(
            child: buttonText,
            textData: buttonTextData,
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

/// ErrorWidget
class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError? error;
  final String? title;
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback? onPressed;

  const ViewStateErrorWidget({
    Key? key,
    @required this.error,
    this.image,
    this.title,
    this.message,
    this.buttonText,
    this.buttonTextData,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultImage;
    var defaultTitle;
    var errorMessage = error?.message;
    String defaultTextData = "重试";
    switch (error?.errorType ?? ViewStateErrorType.defaultError) {
      case ViewStateErrorType.networkTimeOutError:
        defaultImage =
            Icon(IconFonts.pageNetworkError, size: 56, color: Colors.grey);
        defaultTitle = "网络连接异常,请检查网络或稍后重试";
        errorMessage = ''; // 网络异常移除message提示
        break;
      case ViewStateErrorType.defaultError:
        defaultImage =
            const Icon(IconFonts.pageError, size: 56, color: Colors.grey);
        defaultTitle = "加载失败";
        break;

      case ViewStateErrorType.unauthorizedError:
        return ViewStateUnAuthWidget(
          image: image,
          message: message,
          buttonText: buttonText,
          onPressed: onPressed,
        );
    }

    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? defaultImage,
      title: title ?? defaultTitle,
      message: message ?? errorMessage,
      buttonTextData: buttonTextData ?? defaultTextData,
      buttonText: buttonText,
    );
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final VoidCallback? onPressed;

  const ViewStateEmptyWidget(
      {Key? key,
      this.image,
      this.message,
      this.buttonText,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ??
          const Icon(IconFonts.pageEmpty, size: 56, color: Colors.grey),
      title: message ?? "空空如也",
      buttonText: buttonText,
      buttonTextData: "刷新一下",
    );
  }
}

/// 页面未授权
class ViewStateUnAuthWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final VoidCallback? onPressed;

  const ViewStateUnAuthWidget(
      {Key? key,
      this.image,
      this.message,
      this.buttonText,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? ViewStateUnAuthImage(),
      title: message ?? "未登录",
      buttonText: buttonText,
      buttonTextData: "登录",
    );
  }
}

/// 未授权图片
class ViewStateUnAuthImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'loginLogo',
      child: Image.asset(
        ImageHelper.wrapAssets('login_logo.png'),
        width: 130,
        height: 56,
        fit: BoxFit.fitWidth,
        color: Theme.of(context).accentColor,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}

/// 公用Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final String? textData;

  const ViewStateButton({@required this.onPressed, this.child, this.textData})
      : assert(child == null || textData == null);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: child ??
          Text(
            textData ?? "重试",
            style: TextStyle(wordSpacing: 5),
          ),
      onPressed: onPressed,
    );
  }
}
