import 'package:flutter/material.dart';
import '../utils/car_plate_provider.dart';
import 'park_info_screen.dart';
import 'violation_screen.dart';
import 'find_car_screen.dart';
import 'payment_screen.dart';
import 'reservation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateWithCheck(BuildContext context, Widget page) {
    if (!CarPlateProvider.isBound()) {
      showDialog(
        context: context,
        builder: (_) => CarPlateBindingDialog(nextScreen: page),
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🚗 智能停车系统')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTile(context, Icons.local_parking, '停车场信息', ParkInfoScreen(), requirePlate: false),
          _buildTile(context, Icons.warning, '违章提醒', ViolationScreen()),
          _buildTile(context, Icons.search, '车牌寻车', FindCarScreen()),
          _buildTile(context, Icons.payment, '停车缴费', PaymentScreen()),
          _buildTile(context, Icons.event_seat, '预留车位', ReservationScreen()),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, IconData icon, String title, Widget screen, {bool requirePlate = true}) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => requirePlate ? _navigateWithCheck(context, screen) : Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      ),
    );
  }
}


class CarPlateBindingDialog extends StatefulWidget {
  final Widget nextScreen;

  const CarPlateBindingDialog({super.key, required this.nextScreen});

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
            if (plateController.text.isNotEmpty) {
              CarPlateProvider.bindCarPlate(plateController.text);
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => widget.nextScreen));
            }
          },
          child: const Text('继续'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: (_) => widget.nextScreen));
          },
          child: const Text('返回'),
        ),
      ],
    );
  }
}
