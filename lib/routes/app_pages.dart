import 'package:demo_getx/main.dart';
import 'package:demo_getx/pages/page_404.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;
  static GetPage page_404 =
      GetPage(name: Routes.PAGE_404, page: () => Page404());
  static final routes = [
    GetPage(name: Routes.HOME, page: () => MyHomePage(), children: []),
    GetPage(name: Routes.PAGE_OTHER, page: () => Other()),
    GetPage(name: Routes.PAGE_PROFILE, page: () => TestUserProfile()),
  ];
}
