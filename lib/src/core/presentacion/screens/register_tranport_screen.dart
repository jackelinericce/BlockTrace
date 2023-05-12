import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:stotppub/src/core/data/dto/response_data.dart';
import 'package:stotppub/src/core/presentacion/widgets/snackbar_widget.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';
import '../providers/register_transport_provider.dart';

class RegisterTransportScreen extends ConsumerStatefulWidget {
  const RegisterTransportScreen({super.key});

  @override
  RegisterTransportScreenState createState() => RegisterTransportScreenState();
}

class RegisterTransportScreenState
    extends ConsumerState<RegisterTransportScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool isLoadingPage = ref.watch(isLoading);
    return SafeArea(
      child: Scaffold(
        body: (isLoadingPage)
            ? const LoadingWidget()
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    pinned: true,
                    expandedHeight: 350,
                    flexibleSpace: FlexibleSpaceBar(
                      title: const Text('Registrar Transportista'),
                      background: Image.asset(
                        'assets/images/register_transport.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          Form(
                            key: formKey,
                            child: Column(
                              children: const [
                                _FormName(),
                                SizedBox(height: 10),
                                _FormLastName(),
                                SizedBox(height: 10),
                                _FormRuc(),
                                SizedBox(height: 10),
                                _FormAddress(),
                                SizedBox(height: 10),
                                _FormNumber(),
                                SizedBox(height: 10),
                                _FormLicenseNumber(),
                                SizedBox(height: 10),
                                _FormTypeLicense(),
                                SizedBox(height: 10),
                                _FormEmail(),
                                SizedBox(height: 10),
                                _FormPassword(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          _ButtonRegister(ref: ref),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class _FormPassword extends ConsumerWidget {
  const _FormPassword();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterTransportFormNotifier notifierForm =
        ref.watch(registerTransportStateNotifierProvider.notifier);

    return TextFormFieldCustom1(
      initialValue: notifierForm.state.password,
      prefixIcon: const Icon(Icons.password),
      obscureText: true,
      hint: 'Ingrese Contraseña',
      onChanged: (value) {
        notifierForm.setPassword(value);
      },
    );
  }
}

class _FormNumber extends ConsumerWidget {
  const _FormNumber();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterTransportFormNotifier notifierForm =
        ref.watch(registerTransportStateNotifierProvider.notifier);

    return TextFormFieldCustom1(
      initialValue: notifierForm.state.number,
      prefixIcon: const Icon(Icons.phone),
      hint: 'Ingrese Número',
      onChanged: (value) {
        notifierForm.setNumber(value);
      },
    );
  }
}

class _FormEmail extends ConsumerWidget {
  const _FormEmail();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterTransportFormNotifier notifierForm =
        ref.watch(registerTransportStateNotifierProvider.notifier);

    return TextFormFieldCustom1(
      initialValue: notifierForm.state.email,
      prefixIcon: const Icon(Icons.email),
      hint: 'Ingrese Email',
      onChanged: (value) {
        notifierForm.setEmail(value);
      },
    );
  }
}

class _FormRuc extends ConsumerWidget {
  const _FormRuc();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterTransportFormNotifier notifierForm =
        ref.watch(registerTransportStateNotifierProvider.notifier);

    return TextFormFieldCustom1(
      initialValue: notifierForm.state.ruc,
      prefixIcon: const Icon(Icons.reduce_capacity),
      hint: 'Ingrese Dni',
      onChanged: (value) {
        notifierForm.setRuc(value);
      },
    );
  }
}

class _FormLastName extends ConsumerWidget {
  const _FormLastName();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterTransportFormNotifier notifierForm =
        ref.watch(registerTransportStateNotifierProvider.notifier);

    return TextFormFieldCustom1(
      initialValue: notifierForm.state.lastName,
      prefixIcon: const Icon(Icons.person),
      hint: 'Ingrese Apellido',
      onChanged: (value) {
        notifierForm.setLastName(value);
      },
    );
  }
}

class _FormName extends ConsumerWidget {
  const _FormName();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterTransportFormNotifier notifierForm =
        ref.watch(registerTransportStateNotifierProvider.notifier);

    return TextFormFieldCustom1(
      initialValue: notifierForm.state.name,
      prefixIcon: const Icon(Icons.person),
      hint: 'Ingrese Nombre',
      onChanged: (value) {
        notifierForm.setName(value);
      },
    );
  }
}

class _FormAddress extends ConsumerWidget {
  const _FormAddress();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterTransportFormNotifier notifierForm =
        ref.watch(registerTransportStateNotifierProvider.notifier);

    return TextFormFieldCustom1(
      initialValue: notifierForm.state.address,
      prefixIcon: const Icon(Icons.directions),
      hint: 'Ingrese Dirección',
      onChanged: (value) {
        notifierForm.setAddress(value);
      },
    );
  }
}

class _FormLicenseNumber extends ConsumerWidget {
  const _FormLicenseNumber();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterTransportFormNotifier notifierForm =
        ref.watch(registerTransportStateNotifierProvider.notifier);

    return TextFormFieldCustom1(
      initialValue: notifierForm.state.licenseNumber,
      prefixIcon: const Icon(Icons.add_card_outlined),
      hint: 'Ingrese número de licencia',
      onChanged: (value) {
        notifierForm.setLicenseNumber(value);
      },
    );
  }
}

class _FormTypeLicense extends ConsumerWidget {
  const _FormTypeLicense();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterTransportFormNotifier notifierForm =
        ref.watch(registerTransportStateNotifierProvider.notifier);
    const data = ['A I', 'A II', 'A III', 'B I', 'B II', 'B III'];
    var category =
        ref.watch(registerTransportStateNotifierProvider).categoryLicense;

    return TextOptionCustom1Widget(
      prefixIcon: const Icon(Icons.type_specimen),
      text: 'Ingrese Categoría de licencia',
      value: category,
      titleOption: 'Eliga una opcion:',
      valueOption: data,
      onChanged: (value) {
        if (value == null) return;
        notifierForm.setCategoryLicense(value);
        context.pop();
      },
    );
  }
}

class _ButtonRegister extends StatelessWidget {
  final WidgetRef ref;
  const _ButtonRegister({
    super.key,
    required this.ref,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return ButtonCustom1Widget(
      text: 'Registrar',
      onPressed: () async {
        ref.read(isLoading.notifier).state = true;

        RegisterTransportFormNotifier notifier =
            ref.read(registerTransportStateNotifierProvider.notifier);
        ResponseData isCreate = await notifier.addData();

        ref.read(isLoading.notifier).update((state) => false);
        if (isCreate.isOk) {
          notifier.cleanData();
          ref.context.pop();
        } else {
          var snac = snackBarWidget(title: 'Error', message: isCreate.menssage);

          ScaffoldMessenger.of(ref.context).showSnackBar(snac);
        }
      },
    );
  }
}
