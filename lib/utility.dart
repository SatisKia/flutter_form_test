import 'package:flutter/foundation.dart';

abstract class MyDirty {
  List<dynamic>? _initValues; // 編集前の値

  // 現在の値を取得する
  List<dynamic> getValues(List<dynamic> values);

  // 現在の値を編集前の値とする
  void clearDirty() {
    _initValues = getValues([]);
  }

  // 編集されているかチェックする
  bool isDirty() {
    return !listEquals(_initValues, getValues([]));
  }
}
