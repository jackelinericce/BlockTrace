import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/data/dto/response_data.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/presentacion/providers/register_order_provider.dart';
import 'package:stotppub/src/core/presentacion/providers/register_vehicle_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/snackbar_widget.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class ProfileInfoVehicleScreen extends ConsumerStatefulWidget {
  RegisterVehicleFormEntity? vehicle;
  ProfileInfoVehicleScreen({super.key, this.vehicle});

  @override
  ProfileInfoVehicleScreenState createState() =>
      ProfileInfoVehicleScreenState();
}

class ProfileInfoVehicleScreenState
    extends ConsumerState<ProfileInfoVehicleScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RegisterVehicleFormNotifier _notifierForm =
        ref.read(registerVehicleStateNotifierProvider.notifier);
    _notifierForm.state.propertyCard = widget.vehicle!.propertyCard;
    _notifierForm.state.numberOfAxes = widget.vehicle!.numberOfAxes;
    _notifierForm.state.long = widget.vehicle!.long;
    _notifierForm.state.width = widget.vehicle!.width;
    _notifierForm.state.hasSure = widget.vehicle!.hasSure;
    _notifierForm.state.hasSoat = widget.vehicle!.hasSoat;
    _notifierForm.state.hasRefrigeration = widget.vehicle!.hasRefrigeration;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    RegisterVehicleFormNotifier notifierForm =
        ref.watch(registerVehicleStateNotifierProvider.notifier);
    bool refrigeration =
        ref.watch(registerVehicleStateNotifierProvider).hasRefrigeration;
    bool sure = ref.watch(registerVehicleStateNotifierProvider).hasSure;
    print('refrigeration is $refrigeration');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información Vehículo'),
      ),
      body: Container(
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
                    enabled: false,
                    label: 'Placa',
                    prefixIcon: const Icon(Icons.pallet),
                    initialValue: widget.vehicle!.registrationNumber,
                  ),
                  // const SizedBox(height: 10),
                  // TextFormFieldCustom1(
                  //   prefixIcon:
                  //       const Icon(Icons.align_horizontal_right_outlined),
                  //   label: 'Tarjeta de Propiedad',
                  //   initialValue: notifierForm.state.propertyCard,
                  //   onChanged: (value) {
                  //     notifierForm.state.propertyCard = (value);
                  //   },
                  // ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    label: 'Número de ejes',
                    prefixIcon:
                        const Icon(Icons.align_horizontal_right_outlined),
                    initialValue: notifierForm.state.numberOfAxes,
                    onChanged: (value) {
                      notifierForm.state.numberOfAxes = (value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    label: 'Largo',
                    prefixIcon:
                        const Icon(Icons.align_horizontal_right_outlined),
                    initialValue: notifierForm.state.long,
                    onChanged: (value) {
                      notifierForm.state.long = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    label: 'Ancho',
                    prefixIcon:
                        const Icon(Icons.align_horizontal_right_outlined),
                    initialValue: notifierForm.state.width,
                    onChanged: (value) {
                      notifierForm.state.width = (value);
                    },
                  ),
                  const SizedBox(height: 10),
                  // TextFormFieldCustom1(
                  //   label: 'Seguro',
                  //   prefixIcon: const Icon(Icons.abc),
                  //   initialValue: notifierForm.state.hasSure,
                  //   onChanged: (value) {
                  //     notifierForm.state.hasSure = (value);
                  //   },
                  // ),
                  SwitchCustom1Widget(
                    prefixIcon: const Icon(Icons.soap),
                    text: 'Seguro',
                    value: sure,
                    onChanged: (value) {
                      ref
                          .read(registerVehicleStateNotifierProvider.notifier)
                          .setHasSure(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    label: 'Soat',
                    prefixIcon: const Icon(Icons.soap),
                    initialValue: notifierForm.state.hasSoat,
                    onChanged: (value) {
                      notifierForm.state.hasSoat = (value);
                    },
                  ),
                  const SizedBox(height: 10),
                  SwitchCustom1Widget(
                    prefixIcon: const Icon(Icons.soap),
                    text: 'Refrigeración',
                    value: refrigeration,
                    onChanged: (value) {
                      ref
                          .read(registerVehicleStateNotifierProvider.notifier)
                          .setHasRefrigeration(value);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          RegisterVehicleFormNotifier notifierForm =
              ref.watch(registerVehicleStateNotifierProvider.notifier);
          ResponseData isEdit =
              await notifierForm.editData(widget.vehicle!.id!);
          if (isEdit.isOk) {
            notifierForm.cleanData();
            ref.context.pop();
            ref.context.pop(ref.refresh(allVehicleProvider));
          } else {
            var snac = snackBarWidget(title: 'Error', message: isEdit.menssage);
            ScaffoldMessenger.of(ref.context).showSnackBar(snac);
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
