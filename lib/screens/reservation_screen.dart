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

  String statusMessage = '🔄 正在加载状态...';
  Color statusColor = Colors.grey;
  bool isLoading = true;
  bool hasReserved = false;

  @override
  void initState() {
    super.initState();
    _loadReservationStatus();
  }

  Future<void> _loadReservationStatus() async {
    final plate = CarPlateProvider.carPlate ?? '未绑定';

    try {
      final data = await api.query(plate);
      String msg = '';
      Color color = Colors.blue;

      if (data['checked_in'] == true) {
        msg = "🚗 已入库，时间：${data['checkin_time']}";
        color = Colors.green;
      } else if (data['reserved'] == true) {
        msg = "📌 已预约";
        color = Colors.orange;
        hasReserved = true;
      } else {
        msg = "ℹ️ 无预约记录";
        color = Colors.grey;
      }

      setState(() {
        statusMessage = msg;
        statusColor = color;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        statusMessage = "❌ 查询失败，请检查网络或服务器：${e.toString()}";
        statusColor = Colors.red;
        isLoading = false;
      });
    }
  }

  void _reserveNow() async {
    final plate = CarPlateProvider.carPlate ?? '未绑定';

    final res = await api.makeReservation(plate);
    setState(() {
      if (res['success']) {
        statusMessage = "✅ ${res['message']}";
        statusColor = Colors.green;
        hasReserved = true;
      }
      else {
        statusMessage = "❌ 预约失败：${res['message']}";
        statusColor = Colors.red;
        hasReserved = false;
      }
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('📍 预约车位')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              statusMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: statusColor),
            ),
            const SizedBox(height: 20),
            if (!isLoading && !hasReserved)
              ElevatedButton.icon(
                icon: const Icon(Icons.event_available),
                label: const Text('立即预约'),
                onPressed: _reserveNow,
              ),
          ],
        ),
      ),
    ),
  );
}
}
