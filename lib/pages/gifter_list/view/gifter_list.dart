import 'package:flutter/material.dart';
import 'package:gifter/controller/drop_down_provider.dart';
import 'package:gifter/pages/gifter_list/header_part.dart';
import 'package:gifter/pages/home/view/home_screen.dart';
import 'package:provider/provider.dart';

class GifterList extends StatelessWidget {
  const GifterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gift Counter'),
        centerTitle: true,
        leading: Consumer<DropDownProvider>(
          builder: (context, value, child) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context)=> const Home()), (route) => false);
                value.setToNull();
              }
            );
          }
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: HeaderPart(),
      ),
    );
  }
}
