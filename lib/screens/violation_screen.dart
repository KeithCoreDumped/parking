import 'package:flutter/material.dart';
import '../utils/car_plate_provider.dart';

class ViolationScreen extends StatelessWidget {
  const ViolationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plate = CarPlateProvider.carPlate ?? '未知';
    final violation = {
      'time': '2024-04-08 14:30',
      'reason': '超时停车'
    };

    return Scaffold(
      appBar: AppBar(title: const Text('违章提醒')),
      body: Center(
        child: ElevatedButton(
          child: const Text('查看违章记录'),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('车牌：$plate'),
              content: Text('违章时间: ${violation['time']}\n原因: ${violation['reason']}'),
              actions: [
                TextButton(
                  child: const Text('知道了'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
