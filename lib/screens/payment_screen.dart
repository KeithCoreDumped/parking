import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/car_plate_provider.dart';
import 'dart:async';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ApiService api = ApiService();
  String message = '加载中...';
  double? fee;
  bool showPayButton = false;
  Timer? _timer;
  DateTime? checkinTime;
  DateTime? checkoutTime;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => updateRealtimeInfo());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchInitialData() async {
    final res = await api.query(CarPlateProvider.carPlate!);
    setState(() {
      if (res['checked_in'] != true) {
        message = '🚫 无待付账单';
        fee = null;
        showPayButton = false;
        checkinTime = null;
        checkoutTime = null;
      } else {
        checkinTime = DateTime.parse(res['checkin_time']);
        if (res['checked_out'] == true) {
          checkoutTime = DateTime.parse(res['checkout_time']);
          showPayButton = true;
        } else {
          checkoutTime = null;
          showPayButton = false;
        }
      }
    });
  }

  void updateRealtimeInfo() {
    if (checkinTime == null) return;

    final endTime = checkoutTime ?? DateTime.now();
    final duration = endTime.difference(checkinTime!);
    final minutes = (duration.inSeconds / 60).ceil(); // 每开始1分钟就计费
    fee = minutes * 5.0;

    final hoursStr = (duration.inHours).toString().padLeft(2, '0');
    final minutesStr = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final secondsStr = (duration.inSeconds % 60).toString().padLeft(2, '0');
    final timeStr = "$hoursStr:$minutesStr:$secondsStr";

    setState(() {
      if (checkoutTime != null) {
        message = '已离场\n停车时长：$timeStr\n总费用：$fee 元';
      } else {
        message = '已入场，停车中\n当前时长：$timeStr\n当前费用：$fee 元\n⚠ 请在离场时支付';
      }
    });
  }

  void pay() async {
    final res = await api.pay(CarPlateProvider.carPlate!);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('✅ 支付成功'),
        content: Text('车牌：${CarPlateProvider.carPlate}\n支付金额：${fee?.toStringAsFixed(2)} 元\n${res['message']}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💳 停车缴费')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            if (showPayButton)
              ElevatedButton.icon(
                icon: const Icon(Icons.payment),
                label: Text('点击支付 ${fee?.toStringAsFixed(2)} 元'),
                onPressed: pay,
              ),
          ],
        ),
      ),
    );
  }
}
