import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/data/dto/response_data.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/presentacion/providers/register_order_provider.dart';
import 'package:stotppub/src/core/presentacion/providers/register_transport_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/snackbar_widget.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class ProfileInfoDriverScreen extends ConsumerStatefulWidget {
  RegisterTransportFormEntity? driver;
  ProfileInfoDriverScreen({super.key, this.driver});

  @override
  ProfileInfoDriverScreenState createState() => ProfileInfoDriverScreenState();
}

class ProfileInfoDriverScreenState
    extends ConsumerState<ProfileInfoDriverScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RegisterTransportFormNotifier _notifierForm =
        ref.read(registerTransportStateNotifierProvider.notifier);
    _notifierForm.setName(widget.driver!.name);
    _notifierForm.setLastName(widget.driver!.lastName);
    _notifierForm.setAddress(widget.driver!.address);
    _notifierForm.setRuc(widget.driver!.ruc);
    _notifierForm.setNumber(widget.driver!.number);
    _notifierForm.setLicenseNumber(widget.driver!.licenseNumber);
    print('driver!.categoryLicense ${widget.driver!.categoryLicense}');
    _notifierForm.state.categoryLicense = widget.driver!
        .categoryLicense; //setCategoryLicense(widget.driver!.categoryLicense);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    RegisterTransportFormNotifier notifierForm =
        ref.watch(registerTransportStateNotifierProvider.notifier);
    var category =
        ref.watch(registerTransportStateNotifierProvider).categoryLicense;

    const allCategoryLicense = ['A I', 'A II', 'A III', 'B I', 'B II', 'B III'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información Conductor'),
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
                    prefixIcon: const Icon(Icons.person),
                    label: 'Nombre',
                    initialValue: notifierForm.state.name, //driver?.name ?? '',
                    onChanged: (value) {
                      notifierForm.setName(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    enabled: false,
                    prefixIcon: const Icon(Icons.person),
                    label: 'Apellido',
                    initialValue: notifierForm.state.lastName,
                    onChanged: (value) {
                      notifierForm.setLastName(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    enabled: false,
                    prefixIcon: const Icon(Icons.person),
                    label: 'Ruc',
                    initialValue: notifierForm.state.ruc,
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    prefixIcon: const Icon(Icons.directions),
                    label: 'Dirección',
                    initialValue: notifierForm.state.address,
                    onChanged: (value) {
                      notifierForm.setAddress(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    prefixIcon: const Icon(Icons.phone),
                    label: 'Teléfono',
                    initialValue: notifierForm.state.number,
                    onChanged: (value) {
                      notifierForm.setNumber(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    prefixIcon: const Icon(Icons.add_card_outlined),
                    label: 'Licencia',
                    initialValue: notifierForm.state.licenseNumber,
                    onChanged: (value) {
                      // widget.driver?.licenseNumber = value;
                      notifierForm.setLicenseNumber(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextOptionCustom1Widget(
                    prefixIcon: const Icon(Icons.person),
                    text: 'Tipo de licencia',
                    value: category, //notifierForm.state.categoryLicense,
                    titleOption: 'Eliga una opcion:',
                    valueOption: allCategoryLicense,
                    onChanged: (value) {
                      if (value == null) return;
                      // widget.driver?.categoryLicense = value;
                      notifierForm.setCategoryLicense(value);
                      context.pop();
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    enabled: false,
                    prefixIcon: const Icon(Icons.person),
                    label: 'Correo',
                    initialValue: widget.driver?.email ?? 'name',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ResponseData isEdit = await notifierForm.editData(widget.driver!.id!);
          if (isEdit.isOk) {
            notifierForm.cleanData();
            ref.context.pop();
            ref.context.pop(ref.refresh(allTransportProvider));
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
