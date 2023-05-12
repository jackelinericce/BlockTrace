import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stotppub/src/core/data/dto/response_data.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/presentacion/providers/register_client_provider.dart';
import 'package:stotppub/src/core/presentacion/providers/register_order_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/snackbar_widget.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class ProfileInfoClientScreen extends ConsumerStatefulWidget {
  final RegisterClientFormEntity? client;
  const ProfileInfoClientScreen({
    super.key,
    this.client,
  });

  @override
  ProfileInfoClientScreenState createState() => ProfileInfoClientScreenState();
}

class ProfileInfoClientScreenState
    extends ConsumerState<ProfileInfoClientScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RegisterClientFormNotifier _notifierForm =
        ref.read(registerClientStateNotifierProvider.notifier);
    _notifierForm.state.name = widget.client!.name;
    _notifierForm.state.lastName = widget.client!.lastName;
    _notifierForm.state.phone = widget.client!.phone;
    _notifierForm.state.address = widget.client!.address;
    print('profile ${_notifierForm.state.name}');
    print('profile ${_notifierForm.state.lastName}');
    print('profile ${_notifierForm.state.phone}');
    print('profile ${_notifierForm.state.address}');
    //_notifierForm.setName(widget.client!.name);
    //_notifierForm.setLastName(widget.client!.lastName);
    //_notifierForm.setPhone(widget.client!.phone);
    // _notifierForm.setDni(widget.client!.dni);
    //_notifierForm.setAddress(widget.client!.address);
    // _notifierForm.setEmail(widget.client!.email);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    RegisterClientFormNotifier notifierForm =
        ref.watch(registerClientStateNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información Cliente'),
      ),
      body: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        // child: Text(client?.name ?? 'name'),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormFieldCustom1(
                    label: 'Nombre',
                    prefixIcon: const Icon(Icons.person),
                    initialValue: widget.client?.name ?? 'name',
                    onChanged: (value) {
                      notifierForm.setName(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    label: 'Apellidos',
                    prefixIcon: const Icon(Icons.person),
                    initialValue: widget.client?.lastName ?? 'lastName',
                    onChanged: (value) {
                      // notifierForm.setLastName(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    label: 'Telefono',
                    prefixIcon: const Icon(Icons.phone),
                    initialValue: widget.client?.phone ?? 'phone',
                    onChanged: (value) {
                      notifierForm.setPhone(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    enabled: false,
                    prefixIcon: const Icon(Icons.run_circle),
                    label: 'Ruc',
                    initialValue: widget.client?.dni ?? 'ruc',
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    label: 'Dirección',
                    prefixIcon: const Icon(Icons.approval),
                    initialValue: widget.client?.address ?? '',
                    onChanged: (value) {
                      notifierForm.setAddress(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldCustom1(
                    enabled: false,
                    prefixIcon: const Icon(Icons.email),
                    label: 'Correo',
                    initialValue: widget.client?.email ?? '',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ResponseData isEdit = await notifierForm.editData(widget.client!.id!);
          if (isEdit.isOk) {
            notifierForm.cleanData();
            ref.context.pop();
            ref.context.pop(ref.refresh(allClientProvider));
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
