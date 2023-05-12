import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stotppub/src/core/data/dto/response_data.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';
import 'package:stotppub/src/core/data/entity/perecedero_entity.dart';

final allClientProvider =
    FutureProvider<List<QueryDocumentSnapshot<Object?>>>((ref) async {
  CollectionReference db = FirebaseFirestore.instance.collection("clientes");
  try {
    var clients = await db.get();
    return clients.docs;
  } catch (e) {
    print('error ${e.toString()}');
    return [];
  }

  // return transports;
});

final allTransportProvider =
    FutureProvider<List<QueryDocumentSnapshot<Object?>>>((ref) async {
  CollectionReference db =
      FirebaseFirestore.instance.collection("trasnportista");
  try {
    var transports = await db.get();
    return transports.docs;
  } catch (e) {
    print('error ${e.toString()}');
    return [];
  }

  // return transports;
});

final allVehicleProvider =
    FutureProvider<List<QueryDocumentSnapshot<Object?>>>((ref) async {
  CollectionReference db = FirebaseFirestore.instance.collection("vehiculo");
  print('vehiclessss');
  try {
    var vehicles = await db.get();
    print(vehicles);
    return vehicles.docs;
  } catch (e) {
    print('error ${e.toString()}');
    return [];
  }
});

final allPerecederoProvider =
    StateProvider<List<PerecederoEntity>>((ref) => []);

final registerOrderStateNotifierProvider =
    StateNotifierProvider<RegisterOrderFormNotifier, RegisterOrderFormEntity>(
  (ref) => RegisterOrderFormNotifier(RegisterOrderFormEntity(
    dni: '',
    phone: '',
    idClient: '',
    idDriver: '',
    idVehicle: '',
    address: '',
    date: '',
    state: '',
  )),
);

class RegisterOrderFormNotifier extends StateNotifier<RegisterOrderFormEntity> {
  RegisterOrderFormNotifier(super.state);

  setDNI(String value) {
    final newState = state.copy(dni: value);
    state = newState;
  }

  setDate(String value) {
    final newState = state.copy(date: value);
    state = newState;
  }

  setPhone(String value) {
    final newState = state.copy(phone: value);
    state = newState;
  }

  setAddress(String value) {
    final newState = state.copy(address: value);
    state = newState;
  }

  setIdClient(String value) {
    final newState = state.copy(idClient: value);
    state = newState;
  }

  setIdDriver(String value) {
    final newState = state.copy(idDriver: value);
    state = newState;
  }

  setIdVehicle(String value) {
    final newState = state.copy(idVehicle: value);
    state = newState;
  }

  setQuantity(String value) {
    final newState = state.copy(quantity: value);
    state = newState;
  }

  setProduct(String value) {
    final newState = state.copy(product: value);
    state = newState;
  }

  setLat(double value) {
    final newState = state.copy(lat: value);
    state = newState;
  }

  setLng(double value) {
    final newState = state.copy(lng: value);
    state = newState;
  }

  Future<ResponseData<RegisterClientFormEntity>> findClientByDni() async {
    CollectionReference db =
        await FirebaseFirestore.instance.collection('clientes');

    try {
      var clientsDB =
          await db.limit(1).where('dni', isEqualTo: state.dni).get();

      List<QueryDocumentSnapshot<Object?>> clientsFind = clientsDB.docs;
      List<RegisterClientFormEntity> clients = clientsFind.map((doc) {
        return RegisterClientFormEntity(
          id: doc['id'] ?? '',
          dni: doc['dni'] ?? '',
          name: doc['name'] ?? '',
          lastName: doc['lastName'] ?? '',
          phone: doc['phone'] ?? '',
        );
      }).toList();

      if (clients.isEmpty) {
        return ResponseData(isOk: false, menssage: 'No se encontro');
      } else {
        return ResponseData(isOk: true, menssage: 'isOK', data: clients.first);
      }
    } catch (e) {
      return ResponseData(isOk: false, menssage: e.toString());
    }
  }

  Future<ResponseData<String>> addData() async {
    CollectionReference db = FirebaseFirestore.instance.collection('order');

    showData();
    final order = <String, dynamic>{
      'id': '',
      'idClient': state.idClient,
      'idDriver': state.idDriver,
      'idVehicle': state.idVehicle,
      'dni': state.dni!,
      'phone': state.phone,
      'address': state.address,
      'date': state.date,
      'product': state.product,
      'quantity': state.quantity,
      'state': 'PROCESO', //state.state ?? 'PROCESO', // TODO revisar,
      'createdAt': Timestamp.now(),
      'lat': state.lat,
      'lng': state.lng,
    };
    try {
      DocumentReference createOrder = await db.add(order);
      String id = createOrder.id;
      db.doc(id).update({'id': id});
      return ResponseData(isOk: true, menssage: 'isOk', data: id);
    } catch (e) {
      return ResponseData(isOk: false, menssage: e.toString(), data: null);
    }
  }

  showData() {
    print(state.idClient);
    print(state.idDriver);
    print(state.idVehicle);
    print(state.quantity);
    print(state.date);
    print(state.address);
    print(state.phone);
    print(state.dni);
  }

  String getDateInText() {
    DateTime d = DateTime.now();
    return '${d.day}/${d.month}/${d.year}';
  }
}
