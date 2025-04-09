import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/car_plate_provider.dart';

class FindCarScreen extends StatelessWidget {
  final ApiService api = ApiService();

  FindCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plate = CarPlateProvider.carPlate ?? '未知';

    return Scaffold(
      appBar: AppBar(title: const Text('🚗 车辆位置')),
      body: FutureBuilder(
        future: api.findCar(plate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return const Center(child: Text('查询失败'));
          final data = snapshot.data!;
          return Center(
            child: Card(
              elevation: 5,
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.directions_car, size: 50),
                    Text('车牌：${data['plate']}', style: const TextStyle(fontSize: 18)),
                    Text('停车场：${data['park']}'),
                    Text('位置：${data['position']}', style: const TextStyle(fontSize: 16)),
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
