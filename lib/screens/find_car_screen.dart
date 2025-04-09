import 'package:flutter/material.dart';
import '../utils/car_plate_provider.dart';

class FindCarScreen extends StatelessWidget {
  const FindCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plate = CarPlateProvider.carPlate ?? '未知';
    final location = 'B2层-15号车位';

    return Scaffold(
      appBar: AppBar(title: const Text('车牌寻车')),
      body: Center(
        child: Text('车牌 $plate 在位置：$location', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
