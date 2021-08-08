import 'package:demo_getx/base/base_state.dart';
import 'package:demo_getx/test/test_two/modes/picture.dart';

class TestTwoState extends BaseState {
  List<Picture> _pictureList = [];

  List<Picture> _pictureList2 = [];

  List<Picture> get pictureList => _pictureList;

  set pictureList(List<Picture> value) {
    _pictureList = value;
  }

  List<Picture> get pictureList2 => _pictureList2;

  set pictureList2(List<Picture> value) {
    _pictureList2 = value;
  }

  TestTwoState() {
    ///Initialize variables
  }
}
