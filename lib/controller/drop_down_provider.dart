

import 'package:flutter/cupertino.dart';
import 'package:gifter/controller/db_helper.dart';
import 'package:gifter/models/gifter_model.dart';

class DropDownProvider with ChangeNotifier{

  DBHelper dbHelper = DBHelper();

  final List<String> _genderOption = [
    'Select Gender',
    'Male',
    'Female'
  ];
  String? _selectedGender;

  List<String> get genderOption => _genderOption;
  String? get selectedGender => _selectedGender;

  setGenderValue(value){
    _selectedGender = value;
    notifyListeners();

  }



  final List<String> _giftTypeOption = [
    'Select Gift Type',
    'TK',
    'GIFT',
    'BOTH'
  ];
  String? _selectedGiftType;

  List<String> get giftTypeOption => _giftTypeOption;
  String? get selectedGiftType => _selectedGiftType;

  setGiftTypeValue(value){
    _selectedGiftType = value;
    notifyListeners();

  }

  setToNull(){
    _selectedGender = _genderOption.first;
    _selectedGiftType = _giftTypeOption.first;
    notifyListeners();
  }

  bool _enableTK = false;
  bool get enableTk => _enableTK;
  bool _enableGift = false;
  bool get enableGift => _enableGift;

  setEnable(){
    if(_selectedGiftType == 'TK'){
      _enableTK = true;
      _enableGift = false;
    }else if(_selectedGiftType == 'GIFT'){
      _enableTK = false;
      _enableGift = true;
    }else if(_selectedGiftType == 'BOTH'){
      _enableTK = true;
      _enableGift = true;
    }else{
      _enableTK = false;
      _enableGift = false;
    }
    notifyListeners();
  }



}