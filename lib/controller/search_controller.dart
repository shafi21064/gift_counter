import 'package:flutter/cupertino.dart';
import 'package:gifter/controller/db_helper.dart';
import 'package:gifter/models/gifter_model.dart';

class SearchProvider extends ChangeNotifier {

  List<GifterModel> _data = [];
  List<GifterModel> get data => _data;

  List<GifterModel> filteredData = [];

  DBHelper _dbHelper = DBHelper();
  DBHelper get dbHelper => _dbHelper;

  String searchName = '', searchGender = '', searchGiftType = '';

  void getData() async {
    _data = await _dbHelper.getGiftData();
    filteredData = _data;
    debugPrint(filteredData.length.toString());
    notifyListeners();
    //filteredData = sortedByModifiedTIme(filteredData);
  }

  void onSearchName(String searchText) {
    filteredData = data
        .where((element) =>
                element.name!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    notifyListeners();
  }

  // void onSearchGender(String gender, giftType) {
  //   if(gender == 'Select Gender' && giftType == 'Select Gift Type'){
  //     filteredData = data;
  //   }else{
  //   filteredData = data
  //       .where((element) =>
  //           element.gender!.toLowerCase().contains(gender.toLowerCase()))
  //       .toList() ;
  //   }
  // }
  // void onSearchGiftType(String giftType, gender) {
  //   if(giftType == 'Select Gift Type' && gender == 'Select Gender'){
  //     filteredData = data;
  //   }else {
  //     filteredData = data
  //         .where((element) =>
  //         element.giftType!.toLowerCase().contains(giftType.toLowerCase()))
  //         .toList();
  //   }
  // }

  void filterData ({required String gender, required String giftType}){
    print('gender= $gender and $giftType');
    if(gender == 'Select Gender' && giftType == 'Select Gift Type'){
      filteredData = data;
    }else if (gender != 'Select Gender' && giftType == 'Select Gift Type'){
      filteredData = data
          .where((element) =>
          element.gender!.toLowerCase().contains(gender.toLowerCase()))
          .toList();
    }else if(gender == 'Select Gender' && giftType != 'Select Gift Type'){
      filteredData = data
          .where((element) =>
          element.giftType!.toLowerCase().contains(giftType.toLowerCase()))
          .toList();
    }else if(gender != 'Select Gender' && giftType != 'Select Gift Type'){
      filteredData = data
          .where((element) =>
          element.giftType!.toLowerCase().contains(giftType.toLowerCase()) &&
      element.gender!.toLowerCase().contains(gender.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

   delete(int index){
    dbHelper.delete(filteredData[index].id);
    filteredData.removeAt(index);
    print('hello $index');
    notifyListeners();
  }
}
