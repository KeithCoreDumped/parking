import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/car_plate_provider.dart';

class ViolationScreen extends StatelessWidget {
  final ApiService api = ApiService();

  ViolationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plate = CarPlateProvider.carPlate ?? '未知';

    return Scaffold(
      appBar: AppBar(title: const Text('🚨 违章记录')),
      body: FutureBuilder(
        future: api.getViolation(plate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return const Center(child: Text('查询失败'));

          final data = snapshot.data!;
          if (data.containsKey('message')) {
            return Center(child: Text(data['message']));
          }

          return Center(
            child: Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('时间：${data['time']}', style: const TextStyle(fontSize: 16)),
                    Text('原因：${data['reason']}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
