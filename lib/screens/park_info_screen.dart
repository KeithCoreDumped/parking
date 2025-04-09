import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ParkInfoScreen extends StatelessWidget {
  final ApiService api = ApiService();

  ParkInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🅿️ 停车场信息')),
      body: FutureBuilder(
        future: api.getParkInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return const Center(child: Text('加载失败'));
          final data = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(leading: Icon(Icons.home), title: Text('名称：${data['name']}')),
              ListTile(leading: Icon(Icons.location_on), title: Text('地址：${data['address']}')),
              ListTile(leading: Icon(Icons.format_list_numbered), title: Text('总车位：${data['total_spaces']}')),
              ListTile(leading: Icon(Icons.local_parking), title: Text('剩余车位：${data['available_spaces']}')),
              ListTile(leading: Icon(Icons.attach_money), title: Text('停车费：${data['price_per_hour']}元/小时')),
            ],
          );
        },
      ),
    );
  }
}
