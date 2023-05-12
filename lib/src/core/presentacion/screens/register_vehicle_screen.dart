import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/presentacion/providers/register_vehicle_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/snackbar_widget.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

import '../../data/entity/entity.dart';
import '../providers/register_transport_provider.dart';

class RegisterVehicleScreen extends ConsumerWidget {
  const RegisterVehicleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool isLoadingPage = ref.watch(isLoading);
    return Scaffold(
      body: (isLoadingPage)
          ? const LoadingWidget()
          : Builder(
              builder: (context) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      pinned: true,
                      expandedHeight: 350,
                      flexibleSpace: FlexibleSpaceBar(
                        title: const Text('Registrar Vehículo'),
                        background: Image.asset(
                          'assets/images/register_vehicle.jpeg',
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
                                children: const [
                                  _FormRegistartionNumber(),
                                  SizedBox(height: 10),
                                  // _FormPropertyCard(),
                                  // SizedBox(height: 10),
                                  _FormNumberOfAxes(),
                                  SizedBox(height: 10),
                                  _FormWidth(),
                                  SizedBox(height: 10),
                                  _FormLong(),
                                  SizedBox(height: 10),
                                  _FormSure(),
                                  SizedBox(height: 10),
                                  _FormSoat(),
                                  SizedBox(height: 10),
                                  _FormRefrigeration(),
                                  SizedBox(height: 10),
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
                );
              },
            ),
    );
  }
}

class _FormLong extends ConsumerWidget {
  const _FormLong();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterVehicleFormNotifier notifierForm =
        ref.watch(registerVehicleStateNotifierProvider.notifier);
    return TextFormFieldCustom1(
      initialValue: notifierForm.state.long,
      prefixIcon: const Icon(Icons.align_horizontal_right_outlined),
      hint: 'Ingrese el largo',
      onChanged: (value) {
        notifierForm.setLong(value);
      },
    );
  }
}

class _FormWidth extends ConsumerWidget {
  const _FormWidth();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterVehicleFormNotifier notifierForm =
        ref.watch(registerVehicleStateNotifierProvider.notifier);

    return TextFormFieldCustom1(
      initialValue: notifierForm.state.width,
      prefixIcon: const Icon(Icons.align_horizontal_right_outlined),
      hint: 'Ingrese el ancho',
      onChanged: (value) {
        notifierForm.setWidth(value);
      },
    );
  }
}

class _FormNumberOfAxes extends ConsumerWidget {
  const _FormNumberOfAxes();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterVehicleFormNotifier notifierForm =
        ref.watch(registerVehicleStateNotifierProvider.notifier);
    return TextFormFieldCustom1(
      initialValue: notifierForm.state.numberOfAxes,
      prefixIcon: const Icon(Icons.align_horizontal_right_outlined),
      hint: 'Ingrese Numero de ejes',
      onChanged: (value) {
        notifierForm.setNumberOfAxes(value);
      },
    );
  }
}

class _FormPropertyCard extends ConsumerWidget {
  const _FormPropertyCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterVehicleFormNotifier notifierForm =
        ref.watch(registerVehicleStateNotifierProvider.notifier);

    return TextFormFieldCustom1(
      initialValue: notifierForm.state.propertyCard,
      prefixIcon: const Icon(Icons.align_horizontal_right_outlined),
      hint: 'Ingrese tarjeta de propiedad',
      onChanged: (value) {
        notifierForm.setPropertyCard(value);
      },
    );
  }
}

class _FormRegistartionNumber extends ConsumerWidget {
  const _FormRegistartionNumber();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterVehicleFormNotifier notifierForm =
        ref.watch(registerVehicleStateNotifierProvider.notifier);
    return TextFormFieldCustom1(
      initialValue: notifierForm.state.registrationNumber,
      prefixIcon: const Icon(Icons.pallet),
      hint: 'Ingrese placa',
      onChanged: (value) {
        notifierForm.setRegistrationNumber(value);
      },
    );
  }
}

class _FormSure extends ConsumerWidget {
  const _FormSure();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool switchValue = ref.watch(registerVehicleStateNotifierProvider).hasSure;
    // RegisterVehicleFormNotifier notifierForm =
    //     ref.watch(registerVehicleStateNotifierProvider.notifier);
    // return TextFormFieldCustom1(
    //   initialValue: notifierForm.state.hasSure,
    //   prefixIcon: const Icon(Icons.abc),
    //   hint: 'Tiene seguro',
    //   onChanged: (value) {
    //     notifierForm.setHasSure(value);
    //   },
    // );
    return SwitchCustom1Widget(
      prefixIcon: const Icon(Icons.soap),
      text: 'Tiene Seguro',
      value: switchValue,
      onChanged: (value) {
        ref
            .read(registerVehicleStateNotifierProvider.notifier)
            .setHasSure(value);
      },
    );
  }
}

class _FormSoat extends ConsumerWidget {
  const _FormSoat();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegisterVehicleFormNotifier notifierForm =
        ref.watch(registerVehicleStateNotifierProvider.notifier);
    return TextFormFieldCustom1(
      initialValue: notifierForm.state.hasSoat,
      prefixIcon: const Icon(Icons.soap),
      hint: 'Tiene soat',
      onChanged: (value) {
        notifierForm.setHasSoat(value);
      },
    );
  }
}

class _FormRefrigeration extends ConsumerWidget {
  const _FormRefrigeration();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool switchValue =
        ref.watch(registerVehicleStateNotifierProvider).hasRefrigeration;

    return SwitchCustom1Widget(
      prefixIcon: const Icon(Icons.soap),
      text: 'Tiene Refrigeration',
      value: switchValue,
      onChanged: (value) {
        ref
            .read(registerVehicleStateNotifierProvider.notifier)
            .setHasRefrigeration(value);
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
  Widget build(BuildContext context) {
    return ButtonCustom1Widget(
      text: 'Registrar',
      onPressed: () async {
        ref.read(isLoading.notifier).state = true;

        RegisterVehicleFormNotifier vehicle =
            ref.read(registerVehicleStateNotifierProvider.notifier);
        var isCreate = await vehicle.addData();
        ref.read(isLoading.notifier).state = false;
        if (isCreate.isOk) {
          vehicle.cleanData();
          ref.context.pop();
        } else {
          var snac = snackBarWidget(title: 'Error', message: isCreate.menssage);

          ScaffoldMessenger.of(ref.context).showSnackBar(snac);
        }
        // print('placa: ${vehicle.registrationNumber}');
        // print('soat: ${vehicle.hasSoat}');
        // print('tarjeta Propiedad: ${vehicle.propertyCard}');
        // print('N! ejes:  ${vehicle.numberOfAxes}');
        // print('ancho: ${vehicle.width}');
        // print('largo: ${vehicle.long}');
        // print('refrigeracion: ${vehicle.hasRefrigeration}');
        // print('seguro: ${vehicle.hasSure}');
      },
    );
  }
}
