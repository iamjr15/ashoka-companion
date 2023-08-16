import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final datetimeProvider = ChangeNotifierProvider((ref) => DateTimeProvider());
class DateTimeProvider extends ChangeNotifier{

  int _index = 0;
  int get index => _index;
  setIndex(int ind){
    _index = ind;
    notifyListeners();
  }

  int _schIndex = 0;
  int get schIndex => _schIndex;
  setScheduleIndex(int ind){
    _schIndex = ind;
    notifyListeners();
  }
}