import 'package:flutter/material.dart';

class ReservationScreen extends StatelessWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reservationInfo = '预约成功：B1-08号位，今日13:00-14:00';

    return Scaffold(
      appBar: AppBar(title: const Text('预留车位')),
      body: Center(
        child: ElevatedButton(
          child: const Text('立即预约'),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('预约信息'),
              content: Text(reservationInfo),
              actions: [
                TextButton(
                  child: const Text('确定'),
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
