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

  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  String result = '';
  Color resultColor = Colors.green;

  // 选择日期（带汉化提示）
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      helpText: "请选择日期",
      cancelText: "取消",
      confirmText: "确认",
      errorFormatText: "输入日期格式有误，请重新输入",
      errorInvalidText: "输入日期不合法，请重新输入",
      fieldLabelText: "输入所选日期",
      fieldHintText: "请输入日期",
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  // 整点时间选择器
  Future<TimeOfDay?> _pickRoundedTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now().replacing(minute: 0),
      cancelText: "取消",
      confirmText: "确认",
      helpText: "请选择时间",
      hourLabelText: "小时",
      minuteLabelText: "分钟",
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );
    if (picked == null) return null;
    return TimeOfDay(hour: picked.hour, minute: 0);
  }

  Future<void> _selectStartTime() async {
    final picked = await _pickRoundedTime();
    if (picked != null) setState(() => startTime = picked);
  }

  Future<void> _selectEndTime() async {
    final picked = await _pickRoundedTime();
    if (picked != null) setState(() => endTime = picked);
  }

  void reserve() async {
    if (selectedDate == null || startTime == null || endTime == null) {
      setState(() {
        result = '❌ 请选择完整的日期和时间段';
        resultColor = Colors.red;
      });
      return;
    }

    final start = Duration(hours: startTime!.hour);
    final end = Duration(hours: endTime!.hour);

    if (end <= start) {
      setState(() {
        result = '❌ 结束时间必须晚于开始时间';
        resultColor = Colors.red;
      });
      return;
    }

    final formattedDate =
        "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
    final timeSlot =
        "${startTime!.format(context)}-${endTime!.format(context)}";

    final res = await api.makeReservation(
      CarPlateProvider.carPlate ?? '未绑定',
      formattedDate,
      timeSlot,
    );

    setState(() {
      result = "✅ 预约成功：${res['spot']}，${res['date']} ${res['time']}";
      resultColor = Colors.green;
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '选择日期';
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  String _formatTime(TimeOfDay? time) {
    return time?.format(context) ?? '选择时间';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📅 预约车位')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(_formatDate(selectedDate)),
              onTap: _selectDate,
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: const Icon(Icons.access_time),
                    title: Text('开始：${_formatTime(startTime)}'),
                    onTap: _selectStartTime,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: const Icon(Icons.access_time),
                    title: Text('结束：${_formatTime(endTime)}'),
                    onTap: _selectEndTime,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.event_available),
              label: const Text('立即预约'),
              onPressed: reserve,
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 16, color: resultColor),
            ),
          ],
        ),
      ),
    );
  }
}
