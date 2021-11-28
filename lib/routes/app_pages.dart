import 'package:demo_getx/main.dart';
import 'package:demo_getx/pages/page_404.dart';
import 'package:demo_getx/routes/route_auth_middleware.dart';
import 'package:demo_getx/test/test_lifecycle/view.dart';
import 'package:demo_getx/test/test_one/view.dart';
import 'package:demo_getx/test/test_three/binding.dart';
import 'package:demo_getx/test/test_three/view.dart';
import 'package:demo_getx/test/test_two/view.dart';
import 'package:demo_getx/test/video/view.dart';
import 'package:demo_getx/test/video2_page_view/view.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static GetPage page_404 =
      GetPage(name: Routes.PAGE_404, page: () => Page404());

  static final routes = [
    GetPage(name: Routes.HOME, page: () => MyHomePage(), children: []),
    GetPage(name: Routes.PAGE_OTHER, page: () => Other()),
    GetPage(
      name: Routes.PAGE_PROFILE,
      page: () => TestUserProfile(),
      middlewares: [RouteAuthMiddleware(priority: 1)],
    ),
    GetPage(name: Routes.PAGE_AUTH, page: () => Auth()),
    GetPage(name: Routes.PAGE_TEST_ONE, page: () => TestOnePage()),
    GetPage(name: Routes.PAGE_TEST_TWO, page: () => TestTwoPage()),
    GetPage(
        name: Routes.PAGE_TEST_THREE,
        page: () => TestThreePage(),
        binding: TestThreeBinding()),
    GetPage(name: Routes.PAGE_TEST_LIFECYCLE, page: () => TestLifecyclePage()),
    GetPage(name: Routes.PAGE_VIDEO, page: () => VideoPage()),
    GetPage(name: Routes.PAGE_VIDEO_2, page: () => Video2PageViewPage()),
  ];
}
