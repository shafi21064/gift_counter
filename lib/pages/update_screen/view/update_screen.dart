import 'package:flutter/material.dart';
import 'package:gifter/models/gifter_model.dart';
import 'package:gifter/pages/update_screen/update_input_screen.dart';


class UpdateScreen extends StatelessWidget {
  final GifterModel gifterModel;
  const UpdateScreen({super.key, required this.gifterModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gift Counter'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          //physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                UpdateInputScreen(gifterModel: gifterModel,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
