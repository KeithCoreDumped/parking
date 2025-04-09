import 'package:flutter/material.dart';
import '../utils/car_plate_provider.dart';

class FindCarScreen extends StatelessWidget {
  const FindCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🚘 寻找车辆')),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.directions_car, size: 60, color: Colors.teal),
                const SizedBox(height: 20),
                Text('车牌：${CarPlateProvider.carPlate}', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                const Text('位置：B2层-15号车位', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
