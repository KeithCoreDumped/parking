import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/car_plate_provider.dart';

class PaymentScreen extends StatelessWidget {
  final ApiService api = ApiService();

  PaymentScreen({super.key});

  void pay(BuildContext context) async {
    final res = await api.pay(CarPlateProvider.carPlate ?? '未知', 10);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('✅ 支付成功'),
        content: Text('车牌：${res['plate']}\n支付金额：${res['amount']}元'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('确认'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💳 停车缴费')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.payment),
          label: const Text('点击支付 10 元'),
          onPressed: () => pay(context),
        ),
      ),
    );
  }
}
