import 'package:flutter/material.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class OptionsMenuTransport extends StatelessWidget {
  const OptionsMenuTransport({
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
          text: 'Información de mis pedidos',
          icon: const Icon(
            Icons.manage_search_rounded,
            size: 35,
          ),
          onClick: () {},
        ),
        // const SizedBox(height: 15),
        // ItemOptionMenu(
        //   text: 'Ingresar código de servicios',
        //   icon: const Icon(
        //     Icons.send_rounded,
        //     size: 35,
        //   ),
        //   onClick: () {},
        // ),
      ],
    );
  }
}
