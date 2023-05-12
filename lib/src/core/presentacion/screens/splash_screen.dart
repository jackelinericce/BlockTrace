import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _validarTipoUsuario();
  }

  @override
  Widget build(BuildContext context) {
    // var t =context.go('/registerTransport');
    // _validarTipoUsuario(context);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              'BlockTrace',
              style: TextStyle(
                fontSize: 38,
              ),
            ),
            SizedBox(height: 100),
            CircularProgressIndicator(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  _validarTipoUsuario() {
    final storage = LocalStorage('my_data.json');
    Future.delayed(const Duration(seconds: 1), () async {
      bool isLogged = storage.getItem('isLogged') ?? false;
      if (isLogged) {
        String typeUser = await storage.getItem('userType');
        String idUser = await storage.getItem('idUser');
        print('jordy $typeUser - $idUser');
        if (typeUser == 'client') {
          context.goNamed('homeClient');
        }
        if (typeUser == 'driver') {
          context.goNamed('homeDriver');
        }
        if (typeUser == 'admin') {
          context.goNamed('homeAdmin');
        }
      } else {
        context.goNamed('signIn');
      }
    });
  }
}
