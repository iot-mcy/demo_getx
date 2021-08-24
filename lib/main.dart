import 'dart:ui';

import 'package:demo_getx/lang/translation_service.dart';
import 'package:demo_getx/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'title'.tr,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      unknownRoute: AppPages.page_404,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: TranslationService.locale,
      translations: TranslationService(),
      fallbackLocale: TranslationService.fallbackLocale,
      // routingCallback: (routing){
      //
      // },
    );
  }
}

class Controller extends GetxController {
  var count = 0.obs;

  increment() {
    return count++;
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        title: Text("home_title".tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'text_hint'.tr,
            ),
            Obx(() {
              return Text(
                "${c.count}",
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            Expanded(
              child: ListView(
                shrinkWrap: false,
                children: [
                  ListTile(
                    title: Text("普通路由"),
                    onTap: () {
                      Get.to(Other());
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("别名路由"),
                    onTap: () {
                      Get.toNamed(Routes.PAGE_OTHER);
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("进入下一个页面，但没有返回上一个页面的选项（用于SplashScreens，登录页面等）"),
                    onTap: () {
                      Get.offNamed(Routes.PAGE_OTHER);
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("未定义路线的导航（404错误）"),
                    onTap: () {
                      Get.toNamed("/a");
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("要导航到下一条路由，并在返回后立即接收或更新数据。"),
                    onTap: () async {
                      var v = await Get.toNamed(Routes.PAGE_OTHER);
                      printInfo(info: v);
                      Get.snackbar("提示", "${v}");
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("发送数据到别名路由、动态网页链接"),
                    onTap: () {
                      Get.toNamed(
                          Routes.PAGE_OTHER + "?device=phone&id=30&name=dm",
                          arguments: 'pa');
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("中间件"),
                    onTap: () {
                      //发送别名路由数据
                      Get.toNamed("/profile/123456?flag=true");
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("Binding使用"),
                    onTap: () {
                      Get.toNamed(Routes.PAGE_TEST_THREE);
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("生命周期"),
                    onTap: () {
                      Get.toNamed(Routes.PAGE_TEST_LIFECYCLE);
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("dialog"),
                    onTap: () {
                      Get.defaultDialog(
                        title: "提示",
                        middleText: "GetX Default Dialog",
                        textCancel: "取消",
                        textConfirm: "确定",
                        onCancel: () {
                          print("取消");
                        },
                        onConfirm: () {
                          print("确定");
                          Get.back();
                        },
                        radius: 10,
                        barrierDismissible: false,
                      );
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("bottomSheet"),
                    onTap: () {
                      Get.bottomSheet(Container(
                        color: Colors.white,
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: Icon(Icons.account_circle),
                              title: Text("User",
                                  style: TextStyle(color: Colors.black)),
                              onTap: () {},
                            ),
                            ListTile(
                              leading: Icon(Icons.supervisor_account_sharp),
                              title: Text("联系人",
                                  style: TextStyle(color: Colors.black)),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ));
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("插件自动生成代码"),
                    onTap: () {
                      Get.toNamed(Routes.PAGE_TEST_ONE);
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("测试Dio网络请求"),
                    onTap: () {
                      Get.toNamed(Routes.PAGE_TEST_TWO);
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("切换主题"),
                    onTap: () {
                      Get.changeTheme(Get.isDarkMode
                          ? ThemeData.light()
                          : ThemeData.dark());
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("切换成中文语言"),
                    onTap: () {
                      var locale = Locale('zh', 'CH');
                      Get.updateLocale(locale);
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("切换成英文语言"),
                    onTap: () {
                      var locale = Locale('en', 'US');
                      Get.updateLocale(locale);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          c.increment();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Other extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取上个页面传过来的参数
    print("Arguments: ${Get.arguments}");
    print("Parameters - Device: ${Get.parameters['device']}");
    print("Parameters - Id: ${Get.parameters['id']}");
    print("Parameters - Name: ${Get.parameters['name']}");

    final Controller c = Get.find();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${c.count}"),
            Text("Arguments: ${Get.arguments}"),
            Text("Parameters - Device: ${Get.parameters['device']}"),
            Text("Parameters - Id: ${Get.parameters['id']}"),
            Text("Parameters - Name: ${Get.parameters['name']}"),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            OutlinedButton(
                onPressed: () {
                  Get.back(result: 'success');
                },
                child: Text("关闭")),
          ],
        ),
      ),
    );
  }
}

class TestUserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Center(
        child: Text(
            "UserID: ${Get.parameters['user_id']}\nFlag=${Get.parameters['flag']}"),
      ),
    );
  }
}

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Center(
        child: Text("登录页面"),
      ),
    );
  }
}
