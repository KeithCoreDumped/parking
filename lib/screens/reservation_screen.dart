import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/car_plate_provider.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final ApiService api = ApiService();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  String result = '';

  void reserve() async {
    final res = await api.makeReservation(
      CarPlateProvider.carPlate ?? '未知',
      dateController.text,
      timeController.text,
    );
    setState(() {
      result = "预约成功：${res['spot']}，${res['date']} ${res['time']}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📅 预约车位')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: dateController, decoration: const InputDecoration(labelText: '日期 (YYYY-MM-DD)')),
            TextField(controller: timeController, decoration: const InputDecoration(labelText: '时间段 (如 13:00-14:00)')),
            const SizedBox(height: 20),
            ElevatedButton.icon(icon: const Icon(Icons.event), label: const Text('预约'), onPressed: reserve),
            const SizedBox(height: 20),
            Text(result, style: const TextStyle(fontSize: 16, color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
