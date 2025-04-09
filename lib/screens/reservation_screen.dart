import 'package:flutter/material.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📍 车位预约')),
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.event_available),
          label: const Text('立即预约'),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('✅ 预约成功'),
              content: const Text('您已预约B1-08号位\n今天 13:00 - 14:00'),
              actions: [TextButton(child: const Text('好的'), onPressed: () => Navigator.pop(context))],
            ),
          ),
        ),
      ),
    );
  }
}
