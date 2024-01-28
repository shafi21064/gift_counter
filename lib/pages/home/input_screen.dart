import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gifter/controller/conter_provider.dart';
import 'package:gifter/controller/db_helper.dart';
import 'package:gifter/controller/drop_down_provider.dart';
import 'package:gifter/models/gifter_model.dart';
import 'package:gifter/pages/home/view/home_screen.dart';
import 'package:gifter/res/compunents/custom_button.dart';
import 'package:gifter/res/compunents/drop_down.dart';
import 'package:gifter/res/compunents/info_input.dart';
import 'package:gifter/utils/utils.dart';
import 'package:provider/provider.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _giftNameController = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  void _insertData(BuildContext context){
    final dropDownProvider = Provider.of<DropDownProvider>(context, listen: false);
    final counterProvider = Provider.of<CounterProvider>(context);
    if(dropDownProvider.selectedGender != 'Select Gender' &&
        dropDownProvider.selectedGiftType != 'Select Gift Type' &&
        dropDownProvider.selectedGender != null &&
        dropDownProvider.selectedGiftType != null &&
        _nameController.text.toString() != '') {
      dbHelper.insertData(GifterModel(
          name: _nameController.text.toString(),
          gender: dropDownProvider.selectedGender,
          giftType: dropDownProvider.selectedGiftType,
          amount: _amountController.text.toString(),
          giftName: _giftNameController.text.toString(),
          date: DateTime.now().toString()
      )).then((value) {
        debugPrint('success');
        counterProvider.addItem();
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => const Home()),
                (route) => false);
        Utils.toastMessage('Data added');
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        Utils.flashBarMessage(
            context: context,
            message: 'Failed',
            icon: const Icon(Icons.info)
        );
      });
    }else if(_nameController.text.toString() == ''){
      Utils.flashBarMessage(
          context: context,
          message: 'Please Enter a Name',
          icon: const Icon(Icons.info),
          flushbarPosition: FlushbarPosition.TOP
      );
    }else if(dropDownProvider.selectedGender == 'Select Gender' ||
        dropDownProvider.selectedGender == null){
      Utils.flashBarMessage(
          context: context,
          message: 'Please Select Gender',
          icon: const Icon(Icons.info),
          flushbarPosition: FlushbarPosition.TOP
      );
    }else if(dropDownProvider.selectedGiftType == 'Select Gift Type' ||
        dropDownProvider.selectedGiftType == null){
      Utils.flashBarMessage(
          context: context,
          message: 'Please Select Gift Type',
          icon: const Icon(Icons.info),
          flushbarPosition: FlushbarPosition.TOP
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _giftNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    return Column(
      children: [
        InfoInputForm(
          labelText: 'Name',
          controller: _nameController,
        ),
        Gap(Utils(context).height * .01),
        Consumer<DropDownProvider>(
            builder: (context, dropDownValue, child) {
              return Column(
                children: [
                  DropDown(
                      options: dropDownValue.genderOption,
                      selectedValue: dropDownValue.selectedGender,
                      onValueChanged: (selectedValue){
                        dropDownValue.setGenderValue(selectedValue);
                      },
                      hintText: 'Select Gender',
                      width: Utils(context).width
                  ),
                  Gap(Utils(context).height * .01),
                  DropDown(

                    options: dropDownValue.giftTypeOption,
                    selectedValue: dropDownValue.selectedGiftType,
                    onValueChanged: (selectedValue){
                      dropDownValue.setGiftTypeValue(selectedValue);
                      dropDownValue.setEnable();
                    },
                    hintText: 'Select Gift Type',
                    width: Utils(context).width,

                  ),
                  Gap(Utils(context).height * .01),
                  InfoInputForm(
                    labelText: 'Amount',
                    controller: _amountController,
                    enabledField: dropDownValue.enableTk,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  Gap(Utils(context).height * .01),
                  InfoInputForm(
                    labelText: 'Gift Name',
                    controller: _giftNameController,
                    enabledField: dropDownValue.enableGift,
                    textInputAction: TextInputAction.done,
                  ),
                  Gap(Utils(context).height * .1),
                  CustomButton(
                    buttonName: 'Save',
                    onTap: (){
                      if(_nameController.text.toString() == ''){
                        Utils.flashBarMessage(
                            context: context,
                            message: 'Please Enter a Name',
                            icon: const Icon(Icons.info),
                            flushbarPosition: FlushbarPosition.TOP
                        );
                      }else if(dropDownValue.selectedGender == 'Select Gender' ||
                          dropDownValue.selectedGender == null) {
                        Utils.flashBarMessage(
                            context: context,
                            message: 'Please Select Gender',
                            icon: const Icon(Icons.info),
                            flushbarPosition: FlushbarPosition.TOP
                        );
                      }else if(dropDownValue.selectedGiftType == 'Select Gift Type' ||
                          dropDownValue.selectedGiftType == null){
                        Utils.flashBarMessage(
                            context: context,
                            message: 'Please Select Gift Type',
                            icon: const Icon(Icons.info),
                            flushbarPosition: FlushbarPosition.TOP
                        );
                      }else{
                        dbHelper.insertData(GifterModel(
                            name: _nameController.text.toString(),
                            gender: dropDownValue.selectedGender,
                            giftType: dropDownValue.selectedGiftType,
                            amount: _amountController.text.toString(),
                            giftName: _giftNameController.text.toString(),
                            date: DateTime.now().toString()
                        )).then((value) {
                          debugPrint('success');
                          counterProvider.addItem();
                          Utils.toastMessage('Data added');
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const Home()));
                          dropDownValue.setToNull();
                        }).onError((error, stackTrace) {
                          debugPrint(error.toString());
                          Utils.flashBarMessage(
                              context: context,
                              message: 'Failed',
                              icon: const Icon(Icons.info)
                          );
                        });
                      }
                    },
                  )
                ],
              );
            }
        )
        // InfoInputForm(),
      ],
    );
  }
}
