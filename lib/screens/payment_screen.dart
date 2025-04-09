import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = 2;
    final fee = duration * 5;

    return Scaffold(
      appBar: AppBar(title: const Text('付款')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('停车时长：$duration 小时，应付：$fee 元'),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('模拟支付'),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('支付成功'),
                  content: Text('支付金额：$fee元'),
                  actions: [
                    TextButton(
                      child: const Text('确定'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
