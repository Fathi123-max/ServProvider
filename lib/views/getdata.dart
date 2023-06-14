import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ExampleScreen extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    String name = box.read('name') ?? '';
    String phone = box.read('phone') ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Example Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: $name'),
            Text('Phone: $phone'),
          ],
        ),
      ),
    );
  }
}
