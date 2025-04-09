import 'package:flutter/material.dart';

class ParkInfoScreen extends StatelessWidget {
  const ParkInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🅿️ 停车场信息')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(leading: Icon(Icons.home), title: Text('名称：智慧停车场A区')),
            ListTile(leading: Icon(Icons.location_on), title: Text('地址：XX路123号')),
            ListTile(leading: Icon(Icons.format_list_numbered), title: Text('总车位：200')),
            ListTile(leading: Icon(Icons.local_parking), title: Text('剩余车位：48')),
            ListTile(leading: Icon(Icons.attach_money), title: Text('停车费：5元/小时')),
          ],
        ),
      ),
    );
  }
}
