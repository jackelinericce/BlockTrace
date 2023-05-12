import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/delegate/search_perecedero_delegate.dart';
import 'package:stotppub/src/core/presentacion/providers/register_order_provider.dart';
import 'package:stotppub/src/core/presentacion/widgets/snackbar_widget.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class RegisterOrderScreen extends ConsumerStatefulWidget {
  const RegisterOrderScreen({super.key});

  @override
  RegisterOrderScreenState createState() => RegisterOrderScreenState();
}

class RegisterOrderScreenState extends ConsumerState<RegisterOrderScreen> {
  late PageController pageController;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  String codigoCreado = '';
  @override
  void initState() {
    super.initState();
    // final position = await _geolocatorPlatform.getCurrentPosition();
    // print(position);
    pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: 350,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Crear Solicitud'),
                background: Image.asset(
                  'assets/images/register_request.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              //pageViewUbication(ref),
              pageViewContentData(ref),
              pageViewContentTransportAsignar(ref),
              pageViewContentVehicleAsignar(ref),
              pageViewContentInfo(ref)
            ],
          ),
        ),
      ),
    );
  }

  Widget pageViewUbication(WidgetRef ref) {
    const CameraPosition _positionCamera = CameraPosition(
      target: LatLng(
        37.42796133580664,
        -122.085749655962,
      ),
      zoom: 14.4746,
    );
    return Stack(
      children: [
        Container(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 5),
          color: Colors.red,
          child: GestureDetector(
            onTap: () async {
              print('onTap');
            },
            child: Container(
              child: Text('ubicación'),
            ),
          ),
        ),
        const GoogleMap(
          mapType: MapType.normal,
          mapToolbarEnabled: true,
          initialCameraPosition: _positionCamera,
        ),
      ],
    );
  }

  Widget pageViewContentData(WidgetRef ref) {
    RegisterOrderFormNotifier notifier =
        ref.watch(registerOrderStateNotifierProvider.notifier);
    var myProduct = ref.watch(registerOrderStateNotifierProvider).product;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormFieldCustom1(
                    initialValue: notifier.state.idClient,
                    prefixIcon:
                        const Icon(Icons.align_horizontal_right_outlined),
                    hint: 'Ingrese RUC cliente',
                    onChanged: (value) {
                      notifier.setDNI(value);
                    },
                  ),
                ),
                Container(
                  width: 90,
                  padding: const EdgeInsets.all(8),
                  child: ButtonCustom1Widget(
                    text: 'VER',
                    onPressed: () async {
                      var data = await notifier.findClientByDni();
                      if (!data.isOk) {
                        var snackBar = snackBarWidget(
                          title: 'Error',
                          message: data.menssage,
                        );
                        ScaffoldMessenger.of(ref.context)
                            .showSnackBar(snackBar);
                      } else {
                        var snackBar = snackBarWidget(
                          type: ContentType.success,
                          title: 'Encontrado',
                          message:
                              'Usuario ${data.data!.name} ${data.data!.lastName}',
                        );
                        ScaffoldMessenger.of(ref.context)
                            .showSnackBar(snackBar);
                        notifier.setIdClient(data.data!.id!);
                        print('telll ${data.data!.toString()}');
                        notifier.setPhone(data.data!.phone);
                      }
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            //TODO:
            //vincular con el dato del usuario
            TextFormFieldCustom1(
              enabled: false,
              // initialValue: notifier.state.phone,
              prefixIcon: const Icon(Icons.phone),
              hint: (notifier.state.phone.length == 0)
                  ? 'Teléfono cliente'
                  : notifier.state.phone,
              // onChanged: (value) {
              //   notifier.setPhone(value);
              // },
            ),
            const SizedBox(height: 15),
            //TODO
            // buscar por el nombre no GPS
            GestureDetector(
              onTap: () async {
                SearchDestinationMapBox? dataUbication =
                    await ref.context.push('/searchDestination');
                if (dataUbication == null) {
                  print('dataUbication nula');
                  return;
                }
                print('dataUbication ${dataUbication.lat.toString()}');
                print('dataUbication ${dataUbication.lng.toString()}');
                print('dataUbication ${dataUbication.text.toString()}');
                // print('ft es');
                // print(ft);
                // print('-------');
                notifier.setLat(dataUbication.lat);
                notifier.setLng(dataUbication.lng);

                notifier
                    .setAddress('${dataUbication.lat};${dataUbication.lng}');
              },
              child: TextFormFieldCustom1(
                enabled: false,
                // initialValue: notifier.state.address,
                prefixIcon: const Icon(Icons.house),
                hint: (notifier.state.address.length == 0)
                    ? 'Ingrese Dirección'
                    : notifier.state.address,
                onChanged: (value) {
                  notifier.setAddress(value);
                },
              ),
            ),
            const SizedBox(height: 15),
            TextDateCustom1Widget(
              value: notifier.state.date,
              prefixIcon: const Icon(Icons.calendar_month),
              onTap: () async {
                DateTime? data = await showDatePicker(
                  helpText: 'Ingrese Fecha',
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2024),
                );
                if (data == null) return;
                print(data.toUtc());
                notifier.setDate('${data.day}/${data.month}/${data.year}');
              },
            ),
            const SizedBox(height: 15),
            TextFormProductWidget(notifier: notifier, myProduct: myProduct),
            const SizedBox(height: 15),
            TextFormFieldCustom1(
              initialValue: notifier.state.quantity,
              prefixIcon: const Icon(Icons.numbers),
              hint: 'Ingrese cantidad',
              onChanged: (value) {
                notifier.setQuantity(value);
              },
            ),
            const SizedBox(height: 15),
            ButtonCustom1Widget(
              text: 'ASIGNAR',
              onPressed: () {
                if (notifier.state.idClient == '') {
                  var snackBar = snackBarWidget(
                    title: 'Error',
                    message: 'No hay un cliente asociado',
                  );
                  ScaffoldMessenger.of(ref.context).showSnackBar(snackBar);
                } else {
                  pageController.animateToPage(
                    1,
                    duration: const Duration(seconds: 1),
                    curve: Curves.bounceIn,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget pageViewContentTransportAsignar(WidgetRef ref) {
    var all = ref.watch(allTransportProvider);

    return Container(
      child: all.when(
          data: (data) {
            List<RegisterTransportFormEntity> transports = data.map(
              (doc) {
                return RegisterTransportFormEntity(
                    name: doc["name"],
                    lastName: doc["lastName"],
                    id: doc['id'],
                    licenseNumber: doc['licenseNumber'],
                    categoryLicense: doc['categoryLicense']);
              },
            ).toList();
            if (transports.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('No hay ningun Transportista'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ButtonCustom1Widget(
                      text: 'ATRAS',
                      onPressed: () {
                        ref.context.pop();
                      },
                    ),
                  ),
                ],
              );
            }
            return ListView.builder(
                itemCount: transports.length,
                itemBuilder: (_, i) {
                  RegisterTransportFormEntity transportData = transports[i];

                  return ItemTransportAvailableWidget(
                    name: transportData.name,
                    lastName: transportData.lastName,
                    licenseNumber: transportData.licenseNumber,
                    categoryLicense: transportData.categoryLicense,
                    onPressed: () {
                      RegisterOrderFormNotifier notifier =
                          ref.read(registerOrderStateNotifierProvider.notifier);
                      notifier.setIdDriver(transportData.id!);
                      // var fff = ref.read(registerOrderStateNotifierProvider);
                      // print(fff.ruc);
                      pageController.animateToPage(
                        2,
                        duration: const Duration(seconds: 1),
                        curve: Curves.bounceIn,
                      );
                    },
                  );
                });
          },
          error: (e, _) => Text('Hubo un error ${e.toString()}'),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }

  Widget pageViewContentVehicleAsignar(WidgetRef ref) {
    var all = ref.watch(allVehicleProvider);
    return Container(
      child: all.when(data: (data) {
        var vehicles = data.map((doc) {
          return RegisterVehicleFormEntity(
            propertyCard: doc["propertyCard"],
            numberOfAxes: doc["numberOfAxes"],
            id: doc["id"],
            width: doc["width"],
            long: doc["long"],
            hasSoat: doc["hasSoat"],
            hasRefrigeration: doc["hasRefrigeration"],
          );
        }).toList();

        if (vehicles.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('No hay ningun Vehiculo'),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ButtonCustom1Widget(
                  text: 'ATRAS',
                  onPressed: () {
                    ref.context.pop();
                  },
                ),
              ),
            ],
          );
        }
        return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (_, i) {
              RegisterVehicleFormEntity vehicleData = vehicles[i];

              return ItemVehicleAvailableWidget(
                id: vehicleData.id!,
                hasRefrigeration: vehicleData.hasRefrigeration,
                hasSoat: vehicleData.hasSoat,
                long: vehicleData.long,
                numberOfAxes: vehicleData.numberOfAxes,
                propertyCard: vehicleData.propertyCard,
                width: vehicleData.width,
                onPressed: () async {
                  RegisterOrderFormNotifier notifier =
                      ref.read(registerOrderStateNotifierProvider.notifier);
                  notifier.setIdVehicle(vehicleData.id!);

                  var isCreate = await notifier.addData();
                  if (isCreate.isOk) {
                    setState(() {
                      codigoCreado = isCreate.data!;
                    });
                  }
                  pageController.animateToPage(
                    3,
                    duration: const Duration(seconds: 1),
                    curve: Curves.bounceIn,
                  );
                },
              );
            });
      }, error: (e, _) {
        return Text('Hubo un error ${e.toString()}');
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }

  Widget pageViewContentInfo(WidgetRef ref) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Solicitud Asiganada'),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('N^ de envio: '), Text('2315213')],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Codigo asignado: '), Text('- $codigoCreado -')],
          ),
          const SizedBox(height: 25),
          ButtonCustom1Widget(
            text: 'Terminado',
            onPressed: () {
              ref.context.pop();
            },
          )
        ],
      ),
    );
  }
}

class TextFormProductWidget extends ConsumerWidget {
  const TextFormProductWidget({
    super.key,
    required this.notifier,
    required this.myProduct,
  });

  final RegisterOrderFormNotifier notifier;
  final String myProduct;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // RegisterOrderFormNotifier notifierForm =
    //     ref.watch(registerOrderStateNotifierProvider.notifier);

    // String product = ref.watch(registerOrderStateNotifierProvider).product;
    print('build ${notifier.state.product}');
    return GestureDetector(
      onTap: () async {
        var per = await showSearch(
            context: context, delegate: SearchPerecederoDelegate(ref: ref));
        if (per == null) return;
        notifier.setProduct(per.name);
      },
      child: TextFormFieldCustom1(
        enabled: false,
        prefixIcon: const Icon(Icons.production_quantity_limits),
        hint: (myProduct.isEmpty) ? 'Ingrese Perecedero' : myProduct,
      ),
    );
  }
}
