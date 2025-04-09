import 'package:flutter/material.dart';
import '../utils/car_plate_provider.dart';

class ViolationScreen extends StatelessWidget {
  const ViolationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🚨 违章提醒')),
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.report),
          label: const Text('查看违章'),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('🚫 违章记录'),
              content: Text('车牌：${CarPlateProvider.carPlate}\n\n时间：2024-04-08 14:30\n原因：超时停车'),
              actions: [TextButton(child: const Text('关闭'), onPressed: () => Navigator.pop(context))],
            ),
          ),
        ),
      ),
    );
  }
}
