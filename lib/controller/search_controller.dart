import 'package:flutter/cupertino.dart';
import 'package:gifter/controller/db_helper.dart';
import 'package:gifter/models/gifter_model.dart';

class SearchProvider extends ChangeNotifier {

  List<GifterModel> _data = [];
  List<GifterModel> get data => _data;

  List<GifterModel> filteredData = [];

  DBHelper _dbHelper = DBHelper();
  DBHelper get dbHelper => _dbHelper;


  void getData() async {
    _data = await _dbHelper.getGiftData();
    filteredData = _data;
    debugPrint(filteredData.length.toString());
    notifyListeners();
  }

  void onSearchName(String searchText) {
    filteredData = data
        .where((element) =>
                element.name!.toLowerCase().startsWith(searchText.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void filterData ({required String gender, required String giftType}){

    print('gender= $gender and $giftType');
    if(gender == 'Select Gender' && giftType == 'Select Gift Type'){
      filteredData = data;
    }else if (gender != 'Select Gender' && giftType == 'Select Gift Type'){
      filteredData = data
          .where((element) =>
          element.gender!.toLowerCase().startsWith(gender.toLowerCase()))
          .toList();
    }else if(gender == 'Select Gender' && giftType != 'Select Gift Type'){
      filteredData = data
          .where((element) =>
          element.giftType!.toLowerCase().startsWith(giftType.toLowerCase()))
          .toList();
    }else if(gender != 'Select Gender' && giftType != 'Select Gift Type'){
      filteredData = data
          .where((element) =>
          element.giftType!.toLowerCase().startsWith(giftType.toLowerCase()) &&
      element.gender!.toLowerCase().startsWith(gender.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

   delete(int index){
    dbHelper.delete(filteredData[index].id);
    filteredData.removeAt(index);
    getData();
    print('hello $index');
    notifyListeners();
  }
}
