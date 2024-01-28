import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gifter/controller/db_helper.dart';
import 'package:gifter/controller/drop_down_provider.dart';
import 'package:gifter/models/gifter_model.dart';
import 'package:gifter/pages/gifter_list/view/gifter_list.dart';
import 'package:gifter/res/compunents/custom_button.dart';
import 'package:gifter/res/compunents/drop_down.dart';
import 'package:gifter/res/compunents/info_input.dart';
import 'package:gifter/utils/utils.dart';
import 'package:provider/provider.dart';

class UpdateInputScreen extends StatefulWidget {
  final GifterModel gifterModel;
  const UpdateInputScreen({super.key, required this.gifterModel});

  @override
  State<UpdateInputScreen> createState() => _UpdateInputScreenState();
}

class _UpdateInputScreenState extends State<UpdateInputScreen> {


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _giftNameController = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _giftNameController.dispose();
    super.dispose();
  }

  void setData(){
    _nameController.text = widget.gifterModel.name.toString();
    _amountController.text = widget.gifterModel.amount.toString();
    _giftNameController.text = widget.gifterModel.giftName.toString();
  }

  @override
  Widget build(BuildContext context) {
    final dropDownProvider = Provider.of<DropDownProvider>(context);
    //dropDownProvider.selectedGender = widget.gifterModel.gender.toString();
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
                    buttonName: 'Update',
                    onTap: (){
                      if(_nameController.text.toString() == ''){
                        Utils.flashBarMessage(
                            context: context,
                            message: 'Please Enter a Name',
                            icon: const Icon(Icons.info),
                            flushbarPosition: FlushbarPosition.TOP
                        );
                      }else if(dropDownValue.selectedGender == 'Select Gender' ||
                          widget.gifterModel.gender.toString() == '') {
                        Utils.flashBarMessage(
                            context: context,
                            message: 'Please Select Gender',
                            icon: const Icon(Icons.info),
                            flushbarPosition: FlushbarPosition.TOP
                        );
                      }else if(dropDownValue.selectedGiftType == 'Select Gift Type' ||
                          widget.gifterModel.giftType.toString() == ''){
                        Utils.flashBarMessage(
                            context: context,
                            message: 'Please Select Gift Type',
                            icon: const Icon(Icons.info),
                            flushbarPosition: FlushbarPosition.TOP
                        );
                      }else{
                        dbHelper.updatedQuantity(GifterModel(
                            id: widget.gifterModel.id,
                            name: _nameController.text.toString(),
                            gender: dropDownValue.selectedGender ?? widget.gifterModel.gender.toString(),
                            giftType: dropDownValue.selectedGiftType ?? widget.gifterModel.giftType.toString(),
                            amount: _amountController.text.toString(),
                            giftName: _giftNameController.text.toString(),
                            date: DateTime.now().toString()
                        )).then((value) {
                          debugPrint('success');
                          debugPrint(_nameController.text.toString());
                          debugPrint(widget.gifterModel.id.toString());
                          debugPrint(widget.gifterModel.gender.toString());
                          debugPrint(widget.gifterModel.giftType.toString());
                          Utils.toastMessage('Data updated');
                          dropDownValue.setToNull();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const GifterList()));
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
