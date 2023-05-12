import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class OptionsMenuClient extends StatelessWidget {
  const OptionsMenuClient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '¡Que deseas averiguar?',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 15),
        ItemOptionMenu(
          text: 'Mis envios entregados',
          icon: const Icon(
            Icons.manage_search_rounded,
            size: 35,
          ),
          onClick: () {
            context.push('/orderClient', extra: 1);
          },
        ),
        const SizedBox(height: 15),
        ItemOptionMenu(
          text: 'Ver reportes de incidencias',
          icon: const Icon(
            Icons.insert_chart_outlined_rounded,
            size: 35,
          ),
          onClick: () {
            // context.push('/incident');
            context.push('/incidentListOrder');
          },
        ),
      ],
    );
  }
}
