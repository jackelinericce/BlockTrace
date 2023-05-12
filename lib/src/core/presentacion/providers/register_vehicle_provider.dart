import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stotppub/src/core/data/dto/response_data.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';

final registerVehicleStateNotifierProvider = StateNotifierProvider<
    RegisterVehicleFormNotifier, RegisterVehicleFormEntity>(
  (ref) => RegisterVehicleFormNotifier(
    RegisterVehicleFormEntity(
      registrationNumber: '',
      propertyCard: '',
      numberOfAxes: '',
      width: '',
      long: '',
      hasRefrigeration: false,
      hasSure: false,
      hasSoat: '',
    ),
  ),
);

class RegisterVehicleFormNotifier
    extends StateNotifier<RegisterVehicleFormEntity> {
  RegisterVehicleFormNotifier(super.state);

  setWidth(String value) {
    final newState = state.copy(width: value);
    state = newState;
  }

  setLong(String value) {
    final newState = state.copy(long: value);
    state = newState;
  }

  setNumberOfAxes(String value) {
    final newState = state.copy(numberOfAxes: value);
    state = newState;
  }

  setPropertyCard(String value) {
    final newState = state.copy(propertyCard: value);
    state = newState;
  }

  setRegistrationNumber(String value) {
    final newState = state.copy(registrationNumber: value);
    state = newState;
  }

  setHasRefrigeration(bool value) {
    final newState = state.copy(hasRefrigeration: value);
    state = newState;
  }

  setHasSoat(String value) {
    final newState = state.copy(hasSoat: value);
    state = newState;
  }

  setHasSure(bool value) {
    final newState = state.copy(hasSure: value);
    state = newState;
    // state.hasSure = value;
  }

  updateData({String? name}) {
    // state.copy(name: name);
  }

  cleanData() {
    state = RegisterVehicleFormEntity(
      id: null,
      registrationNumber: '',
      propertyCard: '',
      numberOfAxes: '',
      width: '',
      long: '',
      hasRefrigeration: false,
      hasSure: false,
      hasSoat: '',
    );
  }

  Future<ResponseData> addData() async {
    CollectionReference db = FirebaseFirestore.instance.collection("vehiculo");

    final vehicle = <String, dynamic>{
      "registrationNumber": state.registrationNumber,
      "propertyCard": state.propertyCard,
      "numberOfAxes": state.numberOfAxes,
      "width": state.width,
      "long": state.long,
      "hasRefrigeration": state.hasRefrigeration,
      "hasSure": state.hasSure,
      "hasSoat": state.hasSoat
    };

    try {
      DocumentReference createVehicle = await db.add(vehicle);
      String id = createVehicle.id;
      db.doc(id).update({'id': id});
      return ResponseData(isOk: true, menssage: 'isOk', data: null);
    } catch (e) {
      return ResponseData(isOk: false, menssage: e.toString(), data: null);
    }
  }

  Future<ResponseData> editData(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("vehiculo");

    final vehicle = <String, dynamic>{
      // "name": state.registrationNumber,
      // "propertyCard": state.propertyCard,
      "numberOfAxes": state.numberOfAxes,
      "long": state.long,
      "width": state.width,
      "hasSure": state.hasSure,
      "hasSoat": state.hasSoat,
      "hasRefrigeration": state.hasRefrigeration,
    };

    print('propertyCard es ${state.propertyCard}');
    print('numberOfAxes es ${state.numberOfAxes}');
    print('long es ${state.long}');
    print('width es ${state.width}');
    print('hasSure es ${state.hasSure}');
    print('hasSoat es ${state.hasSoat}');
    print('hasRefrigeration es ${state.hasRefrigeration}');

    // return ResponseData(isOk: false, menssage: 'ZzzZZZ.zz');
    try {
      await db.doc(id).update(vehicle);
      return ResponseData(isOk: true, menssage: 'isOK', data: null);
    } catch (e) {
      return ResponseData(isOk: false, menssage: e.toString());
    }
  }
}
