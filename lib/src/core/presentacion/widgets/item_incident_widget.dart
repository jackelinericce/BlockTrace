import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemIncidentWidget extends StatelessWidget {
  final String name;
  const ItemIncidentWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.push('/incidentDetail');
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: const Icon(Icons.report_problem_rounded)),
            Expanded(child: Text(name)),
          ],
        ),
      ),
    );
  }
}
