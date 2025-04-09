import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💰 停车缴费')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('停车时长：2小时', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text('费用：10元', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: Icon(Icons.payment),
              label: const Text('模拟支付'),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('🎉 支付成功'),
                  content: const Text('您已成功支付10元'),
                  actions: [TextButton(child: const Text('确定'), onPressed: () => Navigator.pop(context))],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
