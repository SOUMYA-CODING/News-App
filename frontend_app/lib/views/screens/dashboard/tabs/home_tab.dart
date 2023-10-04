import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/constants/colors.dart';
import 'package:frontend_app/constants/extension.dart';
import 'package:frontend_app/constants/text_strings.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Stream<String> timeStream;

  @override
  void initState() {
    super.initState();
    timeStream = Stream.periodic(
      const Duration(seconds: 1),
      (_) {
        final now = DateTime.now();
        final day = DateFormat('d').format(now);
        final month = DateFormat('MMMM').format(now);
        return 'Today, $day${_getDaySuffix(int.parse(day))} $month';
      },
    );
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ENText.appName,
                  style: TextStyle(
                    color: ENColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0.sp,
                  ),
                ),
                StreamBuilder<String>(
                  stream: timeStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      );
                    } else {
                      return const Text('Loading...');
                    }
                  },
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(FluentSystemIcons.ic_fluent_alert_regular),
            ),
          ],
        ),
      ],
    );
  }
}
