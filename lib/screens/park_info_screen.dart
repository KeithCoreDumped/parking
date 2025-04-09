import 'package:flutter/material.dart';

class ParkInfoScreen extends StatelessWidget {
  const ParkInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = {
      'name': '智慧停车场A区',
      'address': 'XX路123号',
      'total_spaces': 200,
      'available_spaces': 48,
      'price_per_hour': 5
    };

    return Scaffold(
      appBar: AppBar(title: const Text('停车场信息')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('名称: ${data['name']}'),
          Text('地址: ${data['address']}'),
          Text('总车位: ${data['total_spaces']}'),
          Text('剩余车位: ${data['available_spaces']}'),
          Text('停车费: ${data['price_per_hour']}元/小时'),
        ],
      ),
    );
  }
}
