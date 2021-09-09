import 'dart:ui';

import 'package:demo_getx/lang/translation_service.dart';
import 'package:demo_getx/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

List<ThemeData> themeList = [
  ThemeData(primarySwatch: Colors.red),
  ThemeData(primarySwatch: Colors.pink),
  ThemeData(primarySwatch: Colors.purple),
  ThemeData(primarySwatch: Colors.deepPurple),
  ThemeData(primarySwatch: Colors.indigo),
  ThemeData(primarySwatch: Colors.blue),
  ThemeData(primarySwatch: Colors.lightBlue),
  ThemeData(primarySwatch: Colors.cyan),
  ThemeData(primarySwatch: Colors.teal),
  ThemeData(primarySwatch: Colors.green),
  ThemeData(primarySwatch: Colors.lightGreen),
  ThemeData(primarySwatch: Colors.lime),
  ThemeData(primarySwatch: Colors.yellow),
  ThemeData(primarySwatch: Colors.amber),
  ThemeData(primarySwatch: Colors.orange),
  ThemeData(primarySwatch: Colors.deepOrange),
  ThemeData(primarySwatch: Colors.brown),
  ThemeData(primarySwatch: Colors.grey),
  ThemeData(primarySwatch: Colors.blueGrey),
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'title'.tr,
      theme: themeList[0],
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
            // SizedBox(
            //   width: 90,
            //   height: 30,
            //   child: DecoratedBox(
            //     decoration: BoxDecoration(color: Colors.red),
            //   ),
            // ),
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
                    title: Text("切换主题"),
                    onTap: () {
                      Get.defaultDialog(
                        title: "切换主题",
                        content: SizedBox(
                          width: GetPlatform.isWeb ? 300 : double.infinity,
                          height: 400,
                          child: ListView(
                            shrinkWrap: false,
                            children: [
                              ListTile(
                                title: Text("red"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.red),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[0]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("pink"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.pink),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[1]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("purple"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.purple),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[2]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("deepPurple"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.deepPurple),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[3]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("indigo"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.indigo),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[4]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("blue"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.blue),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[5]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("lightBlue"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.lightBlue),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[6]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("cyan"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.cyan),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[7]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("teal"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.teal),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[8]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("green"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.green),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[9]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("lightGreen"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.lightGreen),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[10]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("lime"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.lime),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[11]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("yellow"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.yellow),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[12]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("amber"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.amber),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[13]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("orange"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.orange),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[14]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("deepOrange"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.deepOrange),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[15]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("brown"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.brown),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[16]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("grey"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.grey),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[17]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text("blueGrey"),
                                leading: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Colors.blueGrey),
                                  ),
                                ),
                                onTap: () {
                                  Get.changeTheme(themeList[18]);
                                  Get.back();
                                },
                              ),
                              Divider(height: 0),
                            ],
                          ),
                        ),
                      );
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
                    title: Text("测试视频播放"),
                    onTap: () {
                      Get.toNamed(Routes.PAGE_VIDEO);
                    },
                  ),
                  Divider(height: 0),
                  ListTile(
                    title: Text("测试视频播放fijkplayer"),
                    onTap: () {
                      Get.toNamed(Routes.PAGE_VIDEO_2);
                    },
                  ),
                  Divider(height: 0),
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
