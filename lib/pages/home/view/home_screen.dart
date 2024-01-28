import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gifter/controller/conter_provider.dart';
import 'package:gifter/pages/gifter_list/view/gifter_list.dart';
import 'package:gifter/pages/home/input_screen.dart';
import 'package:gifter/utils/utils.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gift Counter'),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const GifterList())),
              child: Badge(
                isLabelVisible: true,

                label: Consumer<CounterProvider>(
                  builder: (context, value, child) {
                    return Text(value.getGiftCount().toString());
                  }
                ),
                  child: Icon(Icons.people)),
            ),
            Gap(Utils(context).width * .03)
          ],
        ),
        body: const SingleChildScrollView(
          //physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                InputScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
