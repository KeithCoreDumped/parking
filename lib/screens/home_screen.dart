import 'package:flutter/material.dart';
import '../utils/car_plate_provider.dart';
import 'park_info_screen.dart';
import 'violation_screen.dart';
import 'find_car_screen.dart';
import 'payment_screen.dart';
import 'reservation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateWithCheck(BuildContext context, Widget screen) {
    if (!CarPlateProvider.isBound()) {
      showDialog(
        context: context,
        builder: (_) => CarPlateBindingDialog(nextScreen: screen),
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('智能停车管理系统')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('停车场信息展示'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ParkInfoScreen())),
          ),
          ListTile(
            title: const Text('违章提醒'),
            onTap: () => navigateWithCheck(context, ViolationScreen()),
          ),
          ListTile(
            title: const Text('车牌寻车'),
            onTap: () => navigateWithCheck(context, FindCarScreen()),
          ),
          ListTile(
            title: const Text('付款'),
            onTap: () => navigateWithCheck(context, PaymentScreen()),
          ),
          ListTile(
            title: const Text('预留车位'),
            onTap: () => navigateWithCheck(context, ReservationScreen()),
          ),
        ],
      ),
    );
  }
}

class CarPlateBindingDialog extends StatefulWidget {
  final Widget nextScreen;

  CarPlateBindingDialog({required this.nextScreen});

  @override
  _CarPlateBindingDialogState createState() => _CarPlateBindingDialogState();
}

class _CarPlateBindingDialogState extends State<CarPlateBindingDialog> {
  final plateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('绑定车牌'),
      content: TextField(
        controller: plateController,
        decoration: const InputDecoration(hintText: '输入您的车牌号'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            CarPlateProvider.bindCarPlate(plateController.text);
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => widget.nextScreen));
          },
          child: const Text('绑定'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => widget.nextScreen));
          },
          child: const Text('暂不绑定'),
        ),
      ],
    );
  }
}
