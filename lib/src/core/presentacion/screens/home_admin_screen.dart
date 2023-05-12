import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class HomeAdminScreen extends ConsumerWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cuenta administrador'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hola ',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          TextSpan(
                            text: 'ADMIN',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        // GestureDetector(
                        //   onTap: () {
                        //     context.push('/profile');
                        //   },
                        //   child: const Icon(Icons.person),
                        // ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            showCupertinoDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialogLogoutWidget();
                              },
                            );
                          },
                          child: const Icon(Icons.logout_outlined),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(
                  color: Colors.black87,
                  thickness: 1.5,
                ),
                const SizedBox(height: 25),
                // const SizedBox(height: 65),
                const OptionsMenuAdmin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
