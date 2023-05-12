import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ItemTimeLineHistoryOrderWidget extends StatelessWidget {
  final String date;
  final String ubication;
  final String reference;
  const ItemTimeLineHistoryOrderWidget({
    super.key,
    required this.date,
    required this.ubication,
    required this.reference,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      indicatorStyle: IndicatorStyle(
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: Icons.check,
        ),
      ),
      endChild: Container(
        constraints: const BoxConstraints(
          minHeight: 10,
        ),
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FECHA $date'),
              Text('HORA $reference'),
              Text('LUGAR $ubication'),
            ],
          ),
        ),
      ),
    );
  }
}
