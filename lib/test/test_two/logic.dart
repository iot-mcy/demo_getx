import 'package:demo_getx/net/api.dart';
import 'package:get/get.dart';

import 'modes/picture.dart';
import 'state.dart';

class TestTwoLogic extends GetxController {
  final state = TestTwoState();

  void updatePictureList(List<Picture> list) {
    state.pictureList().pictureList = list;
    // state.pictureList(PictureList(pictureList: list));
    List<int> ids = [1];
    update(ids);
  }

  void updatePictureList2(String json) {
    state.pictureList2 = json;
    List<int> ids = [2];
    update(ids);
  }

  void setIdle() {
    state.pictureList().setIdle();
    update();
  }

  void setLoading() {
    state.pictureList().setLoading();
    update();
  }

  void setEmpty() {
    state.pictureList().setEmpty();
    update();
  }

  void setError(e, stackTrace, {String? message}) {
    state.pictureList().setError(e, stackTrace, message: message);
    update();
  }

  void getPictureList() async {
    var params = {
      "limit": 1,
      "adult": false,
      "first": 1,
      "skip": 0,
      "order": "hot"
    };

    try {
      setLoading();
      var response = await httpManager.get(
          "http://service.picasso.adesk.com/v1/vertical/vertical", params);
      if (response == null) {
        setEmpty();
        print("");
      } else {
        var vertical = response['res']['vertical'];
        List<Picture> list = [];
        for (int i = 0; i < vertical.length; i++) {
          Picture pic = Picture.fromJson(vertical[i]);
          list.add(pic);
        }
        updatePictureList(list);
        setIdle();
        print(response);
      }
    } catch (e, s) {
      // logic.setError(e, s);
      print("");
    }
  }

  void getPictureList2() async {
    var params = {
      "limit": 1,
      "adult": false,
      "first": 2,
      "skip": 0,
      "order": "new"
    };
    try {
      setLoading();
      var response = await httpManager.get(
          "http://service.picasso.adesk.com/v1/vertical/vertical", params);
      if (response == null) {
        setEmpty();
        print("");
      } else {
        Future.delayed(Duration(seconds: 3), () {
          updatePictureList2(response.toString());
        });
        setIdle();
        print(response);
      }
    } catch (e, s) {
      setError(e, s);
      print("");
    }
  }
}
