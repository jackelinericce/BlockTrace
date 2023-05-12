import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SignUpTransportScreen extends StatelessWidget {
  const SignUpTransportScreen({super.key});

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
                const _ImageContainer(),
                const SizedBox(height: 15),
                _FormName(nameController: _nameController),
                const SizedBox(height: 10),
                _FormLastName(lastNameController: _lastNameController),
                const SizedBox(height: 10),
                _FormEmail(emailController: _emailController),
                const SizedBox(height: 10),
                _FormNumber(numberController: _numberController),
                const SizedBox(height: 10),
                _FormPassword(passwordController: _passwordController),
                const SizedBox(height: 10),
                const _ButtonLogin(),
                const SizedBox(height: 10),
                const _TextContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Text(
        'Registrate',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _TextContainer extends StatelessWidget {
  const _TextContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: 'Ya tines una cuenta? ',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.push('/');
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
    );
  }
}

class _ButtonLogin extends StatelessWidget {
  const _ButtonLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
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
    );
  }
}

class _FormPassword extends StatelessWidget {
  const _FormPassword({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Contraseña',
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.remove_red_eye),
      ),
    );
  }
}

class _FormNumber extends StatelessWidget {
  const _FormNumber({
    super.key,
    required TextEditingController numberController,
  }) : _numberController = numberController;

  final TextEditingController _numberController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _numberController,
      decoration: const InputDecoration(
        hintText: 'Teléfono',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _FormEmail extends StatelessWidget {
  const _FormEmail({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        hintText: 'Correo',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _FormName extends StatelessWidget {
  const _FormName({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
        hintText: 'Nombre',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class _FormLastName extends StatelessWidget {
  const _FormLastName({
    super.key,
    required TextEditingController lastNameController,
  }) : _lastNameController = lastNameController;

  final TextEditingController _lastNameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _lastNameController,
      decoration: const InputDecoration(
        hintText: 'Apellidos',
        border: OutlineInputBorder(),
      ),
    );
  }
}
