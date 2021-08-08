import 'package:demo_getx/base/base_controller.dart';
import 'package:demo_getx/net/api.dart';

import 'modes/picture.dart';
import 'state.dart';

class TestTwoLogic extends BaseController<TestTwoState> {
  final state = TestTwoState();

  List<int> ids1 = [1];
  List<int> ids2 = [2];

  TestTwoLogic() {
    setViewState(state);
  }

  void addPicture(Picture picture) {
    state.pictureList.add(picture);
    setIdle(ids1);
  }

  void updatePictureList(List<Picture> list) {
    state.pictureList = list;
  }

  void updatePictureList2(List<Picture> list) {
    state.pictureList2 = list;
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
      setLoading(ids1);
      var response = await httpManager.get(
          "http://service.picasso.adesk.com/v1/vertical/vertical", params);
      if (response == null) {
        setEmpty(ids1);
      } else {
        var vertical = response['res']['vertical'];
        List<Picture> list = [];
        for (int i = 0; i < vertical.length; i++) {
          Picture pic = Picture.fromJson(vertical[i]);
          list.add(pic);
        }
        updatePictureList(list);
        if (list.isEmpty) {
          setEmpty(ids1);
        } else {
          setIdle(ids1);
        }
        print(response);
      }
    } catch (e, s) {
      setError(ids1, e, s);
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
      setLoading(ids2);
      var response = await httpManager.get(
          "http://service.picasso.adesk.com/v1/vertical/vertical", params);
      if (response == null) {
        setEmpty(ids2);
      } else {
        var vertical = response['res']['vertical'];
        List<Picture> list = [];
        for (int i = 0; i < vertical.length; i++) {
          Picture pic = Picture.fromJson(vertical[i]);
          list.add(pic);
        }
        updatePictureList2(list);
        if (list.isEmpty) {
          setEmpty(ids2);
        } else {
          setIdle(ids2);
        }
        print(response);
      }
    } catch (e, s) {
      setError(ids2, e, s);
    }
  }
}
