import 'package:flutter/material.dart';

class MidnightCountdown extends StatefulWidget {
  const MidnightCountdown({super.key});

  @override
  State<MidnightCountdown> createState() => _MidnightCountdownState();
}

class _MidnightCountdownState extends State<MidnightCountdown> {
  late DateTime _midnight;
  late Duration _timeUntilMidnight;

  @override
  void initState() {
    super.initState();
    _updateMidnight();
    // Update every second
    Stream.periodic(const Duration(seconds: 1)).listen((_) {
      _updateMidnight();
    });
  }

  void _updateMidnight() {
    final now = DateTime.now();
    // Calculate next midnight
    _midnight = DateTime(now.year, now.month, now.day + 1);
    _timeUntilMidnight = _midnight.difference(now);

    if (mounted) {
      setState(() {});
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).dialogBackgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Theme.of(context).hoverColor.withOpacity(0.1),
          )
        ],
      ),
      child: Text(
        _formatDuration(_timeUntilMidnight),
        style: const TextStyle(
          fontSize: 36,
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}
