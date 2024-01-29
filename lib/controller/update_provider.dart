import 'package:flutter/cupertino.dart';
import 'package:gifter/controller/db_helper.dart';


class UpdateProvider extends ChangeNotifier{
  String? _updatedGender;

  String? get updatedGender => _updatedGender;
  DBHelper dbHelper = DBHelper();


  setUpdatedGenderValue(value){
    _updatedGender = value;
    notifyListeners();
  }

  String? _updatedGiftType;
  String? get updatedGiftType => _updatedGiftType;

  setUpdatedGiftType(value){
    _updatedGiftType = value;
    notifyListeners();
  }


  bool _enableTK = false;
  bool get enableTk => _enableTK;
  bool _enableGift = false;
  bool get enableGift => _enableGift;


  setEnable(){
    print('gift Type = $_updatedGiftType');
    if(_updatedGiftType == 'TK'){
      _enableTK = true;
      _enableGift = false;
    }else if(_updatedGiftType == 'GIFT'){
      _enableTK = false;
      _enableGift = true;
    }else if(_updatedGiftType == 'BOTH'){
      _enableTK = true;
      _enableGift = true;
    }else{
      _enableTK = false;
      _enableGift = false;
    }
    notifyListeners();
  }
}