import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/car_plate_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

final accent_color = Color(0xffff7f50);
final border_color = Color(0xff404969);
final empty_color = Color(0xffbde4f4);

class FindCarScreen extends StatelessWidget {
  final ApiService api = ApiService();

  FindCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plate = CarPlateProvider.carPlate ?? '未知';
    // final camera_icon_right = SvgPicture.asset(
    //   'camera.svg',
    //   width: 20,
    //   height: 20,
    // );
    // final camera_icon_left = Transform(
    //   alignment: Alignment.center,
    //   transform: Matrix4.rotationY(3.1416),
    //   child: camera_icon_right,
    // );

    return Scaffold(
      appBar: AppBar(title: const Text('🚗 车辆位置')),
      body: FutureBuilder(
        future: api.findCar(plate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return const Center(child: Text('查询失败'));
          final data = snapshot.data!;
          final position = data['position']; // 'A1' or 'A2'

          final dogIcon = SvgPicture.asset(
            'dog.svg',
            width: 30,
            height: 30,
          );

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.directions_car, size: 50),
                        Text(
                          '车牌：${data['plate']}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text('停车场：${data['park']}'),
                        Text(
                          '位置：$position',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '停车场示意图',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // 停车场线框图示
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSpot('A1', position),
                        const SizedBox(width: 30),
                        _buildSpot('A2', position),
                        const SizedBox(width: 30),
                        Column(
                          children: [
                            Container(
                              width: 80,
                              height: 75,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                border: Border.all(
                                  color: border_color,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 5,
                                children: [
                                  Text(
                                    "中控室",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  dogIcon
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 80,
                              height: 35,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                border: Border.all(
                                  color: border_color,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "显示屏",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // camera_icon_left
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        Container(
                          width: 240,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '━  ━  ━  ━  ━  ━  ━  ━  ━',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        // _GateLabel(text: '🚧 入口道闸'),
                        _GateLabel(text: '出入\n道闸'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpot(String label, String currentPosition) {
    final isOccupied = label == currentPosition;
    final carIcon = SvgPicture.asset('car.svg', width: 30, height: 30);
    return Container(
      width: 80,
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isOccupied ? accent_color : empty_color,
        border: Border.all(color: border_color, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // car_icon,
          if (isOccupied) (carIcon),
        ],
      ),
    );
  }
}

class _GateLabel extends StatelessWidget {
  final String text;
  const _GateLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xffdcd1fa),
        border: Border.all(color: border_color, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(Icons.local_parking, color: Colors.blue, size: 30),
          Text(text, style: TextStyle(height: 1, fontSize: 14)),
        ],
      ),
    );
  }
}
