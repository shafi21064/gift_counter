
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterProvider with ChangeNotifier{

  int _giftCount = 0;
  int get giftCount => _giftCount;

  void setPref()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('gift', _giftCount);
    notifyListeners();
  }

  void getPref()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _giftCount = sharedPreferences.getInt('gift') ?? 0;
    notifyListeners();
  }

  void addItem(){
    _giftCount ++;
    setPref();
    print(_giftCount);
    notifyListeners();
  }

  void removeItem(){
    _giftCount --;
    setPref();
    print(_giftCount);
    notifyListeners();
  }

  int getGiftCount(){
    getPref();
    return _giftCount;
  }
}