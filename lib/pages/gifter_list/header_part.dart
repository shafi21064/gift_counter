import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gifter/controller/conter_provider.dart';
import 'package:gifter/controller/db_helper.dart';
import 'package:gifter/controller/drop_down_provider.dart';
import 'package:gifter/controller/search_controller.dart';
import 'package:gifter/models/gifter_model.dart';
import 'package:gifter/pages/gifter_list/info_card.dart';
import 'package:gifter/pages/update_screen/view/update_screen.dart';
import 'package:gifter/res/compunents/drop_down.dart';
import 'package:gifter/utils/utils.dart';
import 'package:provider/provider.dart';

class HeaderPart extends StatefulWidget {
  const HeaderPart({super.key});

  @override
  State<HeaderPart> createState() => _HeaderPartState();
}

class _HeaderPartState extends State<HeaderPart> {

  DBHelper dbHelper = DBHelper();
  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.getData();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    return Column(
      children: [
        SearchBar(
          hintText: 'Search',
          hintStyle: MaterialStateProperty.all(const TextStyle(color: Colors.grey)),
          controller: _searchController,
          elevation: const MaterialStatePropertyAll(0),
          side: const MaterialStatePropertyAll<BorderSide>(BorderSide(color: Colors.black)),
          padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          onChanged: (searchName) {
            searchProvider.onSearchName(searchName);
          },

          leading: const Icon(Icons.search, color: Colors.black,),
        ),
       Gap(Utils(context).height * .01),
       Consumer<DropDownProvider>(
          builder: (context, dropDownValue, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDown(
                    options: dropDownValue.genderOption,
                    selectedValue: dropDownValue.selectedGender,
                    onValueChanged: (selectedValue){
                      dropDownValue.setGenderValue(selectedValue);
                      dropDownValue.setGiftTypeValue(dropDownValue.giftTypeOption.first);
                      searchProvider.filterData(
                          gender: selectedValue!,
                          giftType: '${dropDownValue.selectedGiftType}');
                    },
                    hintText: 'Select Gender',
                    width: Utils(context).width / 2.25),
                DropDown(
                    options: dropDownValue.giftTypeOption,
                    selectedValue: dropDownValue.selectedGiftType,
                    onValueChanged: (selectedValue){
                      dropDownValue.setGiftTypeValue(selectedValue);
                      dropDownValue.setGenderValue(dropDownValue.genderOption.first);
                      searchProvider.filterData(
                          gender: dropDownValue.selectedGender.toString(),
                          giftType: selectedValue! );
                    },
                    hintText: 'Select Gift Type',
                    width: Utils(context).width / 2.25)
              ],
            );
          }
        ),
        Gap(Utils(context).height * .02),
        FutureBuilder(
            future: dbHelper.getGiftData(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return const Center(child: Text('No Data Here'),);
              }else if(snapshot.data!.isEmpty){
                return const Center(child: Text('No Data Here'),);
              } else {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    primary: true,
                    itemCount: searchProvider.filteredData.length,
                      itemBuilder: (context, index){
                      if(searchProvider.filteredData.isEmpty){
                        print(searchProvider.filteredData);
                        return const Center(child: Text('No Data Here'),);
                      }else {
                        return InfoCard(
                            cardOnTap: () {
                              GifterModel gifterModel = snapshot.data![index];
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      UpdateScreen(
                                        gifterModel: gifterModel,
                                      )));
                            },
                            title: '${searchProvider.filteredData[index].name}',
                            subTitle: '${searchProvider.filteredData[index]
                                .name}',
                            deleteWork: () {
                              confirmDialog(context, index);
                            },
                            dateAbdTime: '${searchProvider.filteredData[index]
                                .date}');
                      }}),
                );
              }
            }
        )
      ],
    );
  }


Future<dynamic> confirmDialog(context, int id) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          icon: const Icon(
            Icons.info,
            color: Colors.grey,
          ),
          title: const Text(
            "Are you sure you want to delete?",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Consumer<CounterProvider>(
                builder: (context, value, child) {
                  return Consumer<SearchProvider>(
                    builder: (context, sea, child) {
                      return ElevatedButton(
                        onPressed: () {
                          print('index $id');
                          sea.delete(id);
                          //deleteNote(id);
                          value.removeItem();
                          Navigator.pop(context);
                        },
                        style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const SizedBox(
                            width: 60,
                            child: Text(
                              "Yes",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )),
                      );
                    }
                  );
                }
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const SizedBox(
                    width: 60,
                    child: Text(
                      "no",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        );
      });
}
}
