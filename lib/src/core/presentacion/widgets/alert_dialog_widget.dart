import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';

class AlertDialogLogoutWidget extends StatelessWidget {
  const AlertDialogLogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Logout'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(height: 15),
          Text('Desea salir de la sesión'),
          SizedBox(height: 15),
          // FlutterLogo(
          //   size: 100,
          // )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () async {
            final storage = LocalStorage('my_data.json');
            await storage.setItem('userType', '');
            await storage.setItem('idUser', '');
            await storage.setItem('isLogged', false);
            context.pushReplacement('/');
          },
          child: const Text('Ok'),
        )
      ],
    );
  }
}
