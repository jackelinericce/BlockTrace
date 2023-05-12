import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SignUpClientScreen extends StatelessWidget {
  const SignUpClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _lastNameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _addressController = TextEditingController();
    TextEditingController _numberController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          // physics: ScrollPhysics.,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  // color: Colors.red,
                  width: double.infinity,
                  height: 200,
                  padding: const EdgeInsets.all(16),
                  child: SvgPicture.asset('assets/svgs/register.svg'),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Registrate',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Apellidos',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Correo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Teléfono',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  height: 48,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.amber,
                  onPressed: () {
                    context.push('/home');
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Iniciar',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Ya tines una cuenta? ',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('');
                          },
                        text: 'INICIA SESIÓN',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
