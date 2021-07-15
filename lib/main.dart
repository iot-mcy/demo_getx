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
            ElevatedButton(
                onPressed: () async {
                  //普通路由
                  // Get.to(Other());

                  //命名路由
                  Get.toNamed(Routes.PAGE_OTHER);

                  //进入下一个页面，但没有返回上一个页面的选项（用于SplashScreens，登录页面等）。
                  // Get.offNamed(Routes.PAGE_OTHER);

                  //测试未定义路线的导航（404错误）
                  // Get.toNamed("/aaaa");

                  //要导航到下一条路由，并在返回后立即接收或更新数据。
                  // var v = await Get.toNamed(Routes.PAGE_OTHER);
                  // printInfo(info: v);

                  //发送数据到别名路由、动态网页链接
                  // Get.toNamed(Routes.PAGE_OTHER + "?device=phone&id=30&name=dm",
                  //     arguments: 'pa');
                },
                child: Text("bt_next".tr)),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            OutlinedButton(
              onPressed: () {
                //发送别名路由数据
                Get.toNamed("/profile/123456?flag=true");
              },
              child: Text("用户信息"),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            OutlinedButton(
              onPressed: () {
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
              child: Text("GetX Dialog"),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            OutlinedButton(
              onPressed: () {
                Get.bottomSheet(Container(
                  color: Theme.of(context).bottomSheetTheme.backgroundColor,
                  child: Wrap(
                    children: [
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text("User"),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.supervisor_account_sharp),
                        title: Text("联系人"),
                        onTap: () {},
                      ),
                    ],
                  ),
                ));
              },
              child: Text("GetX BottomSheets"),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            OutlinedButton(
              onPressed: () {
                Get.toNamed(Routes.PAGE_TEST_ONE);
              },
              child: Text("测试GetX 插件自动生成代码"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          c.increment();
          var locale;
          if (c.count % 2 == 0) {
            locale = Locale('zh', 'CH');
          } else {
            locale = Locale('en', 'US');
          }
          Get.updateLocale(locale);
          Get.changeTheme(
              Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
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
