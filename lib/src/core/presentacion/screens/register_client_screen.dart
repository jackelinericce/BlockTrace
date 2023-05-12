import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/data/dto/response_data.dart';
import 'package:stotppub/src/core/presentacion/providers/register_client_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/snackbar_widget.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class RegisterClientScreen extends ConsumerWidget {
  const RegisterClientScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool isLoadingPage = ref.read(isLoadingPageRegisterClient);
    RegisterClientFormNotifier notifierForm =
        ref.watch(registerClientStateNotifierProvider.notifier);

    return SafeArea(
      child: Scaffold(
        body: (isLoadingPage)
            ? const LoadingWidget()
            : CustomScrollView(slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  expandedHeight: 350,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text('Registrar Cliente'),
                    background: Image.asset(
                      'assets/images/register_transport.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormFieldCustom1(
                                prefixIcon: const Icon(Icons.person),
                                hint: 'Ingrese Nombre',
                                initialValue: notifierForm.state.name,
                                onChanged: (value) {
                                  ref
                                      .read(registerClientStateNotifierProvider
                                          .notifier)
                                      .setName(value);
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormFieldCustom1(
                                prefixIcon: const Icon(Icons.person),
                                hint: 'Ingrese Apellidos',
                                initialValue: notifierForm.state.lastName,
                                onChanged: (value) {
                                  ref
                                      .read(registerClientStateNotifierProvider
                                          .notifier)
                                      .setLastName(value);
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormFieldCustom1(
                                prefixIcon: const Icon(Icons.phone),
                                hint: 'Ingrese Teléfono',
                                initialValue: notifierForm.state.phone,
                                onChanged: (value) {
                                  ref
                                      .read(registerClientStateNotifierProvider
                                          .notifier)
                                      .setPhone(value);
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormFieldCustom1(
                                prefixIcon: const Icon(Icons.run_circle),
                                hint: 'Ingrese Ruc',
                                initialValue: notifierForm.state.dni,
                                onChanged: (value) {
                                  ref
                                      .read(registerClientStateNotifierProvider
                                          .notifier)
                                      .setDni(value);
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormFieldCustom1(
                                prefixIcon: const Icon(Icons.approval),
                                hint: 'Ingrese Dirección',
                                initialValue: notifierForm.state.address,
                                onChanged: (value) {
                                  ref
                                      .read(registerClientStateNotifierProvider
                                          .notifier)
                                      .setAddress(value);
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormFieldCustom1(
                                prefixIcon: const Icon(Icons.email),
                                hint: 'Ingrese Email',
                                initialValue: notifierForm.state.email,
                                onChanged: (value) {
                                  ref
                                      .read(registerClientStateNotifierProvider
                                          .notifier)
                                      .setEmail(value);
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormFieldCustom1(
                                prefixIcon: const Icon(Icons.password),
                                obscureText: true,
                                hint: 'Ingrese Contraseña',
                                initialValue: notifierForm.state.password,
                                onChanged: (value) {
                                  ref
                                      .read(registerClientStateNotifierProvider
                                          .notifier)
                                      .setPassword(value);
                                },
                              ),
                              const SizedBox(height: 10),
                              ButtonCustom1Widget(
                                text: 'Registrar',
                                onPressed: () async {
                                  ref
                                      .read(
                                          isLoadingPageRegisterClient.notifier)
                                      .update((state) => true);

                                  var notifier = ref.read(
                                      registerClientStateNotifierProvider
                                          .notifier);
                                  ResponseData isCreate =
                                      await notifier.addData();

                                  ref
                                      .read(
                                          isLoadingPageRegisterClient.notifier)
                                      .update((state) => false);
                                  if (isCreate.isOk) {
                                    notifier.cleanData();
                                    ref.context.pop();
                                  } else {
                                    var snac = snackBarWidget(
                                        title: 'Error',
                                        message: isCreate.menssage);
                                    ScaffoldMessenger.of(ref.context)
                                        .showSnackBar(snac);
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
      ),
    );
  }
}
