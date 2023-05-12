import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stotppub/src/core/data/dto/response_data.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';

// final nameProvider =
//     StateProvider<TextEditingController>((ref) => TextEditingController());
var isLoading = StateProvider<bool>((ref) => false);
final registerTransportStateNotifierProvider = StateNotifierProvider<
    RegisterTransportFormNotifier, RegisterTransportFormEntity>(
  (ref) => RegisterTransportFormNotifier(
    RegisterTransportFormEntity(
      name: '',
      lastName: '',
      ruc: '',
      address: '',
      number: '',
      licenseNumber: '',
      categoryLicense: '',
      email: '',
      password: '',
    ),
  ),
);

class RegisterTransportFormNotifier
    extends StateNotifier<RegisterTransportFormEntity> {
  RegisterTransportFormNotifier(super.state);

  setName(String value) {
    final newState = state.copy(name: value);
    state.name = value;
  }

  setLastName(String value) {
    final newState = state.copy(lastName: value);
    state.lastName = value;
  }

  setRuc(String value) {
    final newState = state.copy(ruc: value);
    state.ruc = value;
  }

  setAddress(String value) {
    final newState = state.copy(address: value);
    state.address = value;
  }

  setNumber(String value) {
    final newState = state.copy(number: value);
    state.number = value;
  }

  setLicenseNumber(String value) {
    final newState = state.copy(licenseNumber: value);
    state.licenseNumber = value;
  }

  setCategoryLicense(String value) {
    // state.categoryLicense = value;
    final newState = state.copy(categoryLicense: value);
    state = newState;
  }

  setEmail(String value) {
    final newState = state.copy(email: value);
    state.email = value;
  }

  setPassword(String value) {
    final newState = state.copy(password: value);
    state.password = value;
  }

  cleanData() {
    state = RegisterTransportFormEntity(
      id: null,
      name: '',
      lastName: '',
      ruc: '',
      address: '',
      number: '',
      licenseNumber: '',
      categoryLicense: '',
      email: '',
      password: '',
    );
  }
  // updateData({String? name}) {
  //   state.copy(name: name);
  // }

  Future<ResponseData<RegisterTransportFormEntity>> addData() async {
    ResponseData<User> createUser =
        await createAccount(state.email, state.password);

    if (!createUser.isOk) {
      return ResponseData(
          isOk: false, menssage: createUser.menssage, data: null);
    }
    String id = createUser.data!.uid;
    CollectionReference db =
        FirebaseFirestore.instance.collection("trasnportista");
    CollectionReference dbType =
        FirebaseFirestore.instance.collection("userType");
    final transport = <String, dynamic>{
      "id": id,
      "name": state.name,
      "lastName": state.lastName,
      "licenseNumber": state.licenseNumber,
      "number": state.number,
      "ruc": state.ruc,
      "categoryLicense": state.categoryLicense,
      "address": state.address,
      "email": state.email,
      "password": state.password,
      "type":"driver",
    };

    try {
      await dbType.doc(id).set({
        "idUser": id,
        "type": "driver",
      });
      var data = await db.doc(id).set(transport);
      // DocumentReference value = await db.add(transport);
      // print('id ${value.id}');
      return ResponseData(isOk: true, menssage: 'isOk', data: null);
    } catch (e) {
      print('err ${e.toString()}');
      return ResponseData(isOk: false, menssage: e.toString(), data: null);
    }
  }

  Future<ResponseData<User>> createAccount(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print('-------userCredential.credential---------');
      print(userCredential.credential);
      return ResponseData(
          isOk: true, menssage: 'isOK', data: userCredential.user);
    } on FirebaseAuthException catch (e) {
      print('e ${e.code}');
      if (e.code == 'weak-password') {
        return ResponseData(
            isOk: false, menssage: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ResponseData(
            isOk: false,
            menssage: 'The account already exists for that email.');
      } else {
        print('e ${e.toString()}');
        return ResponseData(isOk: false, menssage: e.toString());
      }
    }
  }

  Future<ResponseData> editData(String id) async {
    CollectionReference db =
        FirebaseFirestore.instance.collection("trasnportista");
    final transport = <String, dynamic>{
      "name": state.name,
      "lastName": state.lastName,
      "licenseNumber": state.licenseNumber,
      "number": state.number,
      "categoryLicense": state.categoryLicense,
      "address": state.address,
    };
    print('id es $id');
    print('name es ${state.name}');
    print('lastName es ${state.lastName}');
    print('licenseNumber es ${state.licenseNumber}');
    print('number es ${state.number}');
    print('categoryLicense es ${state.categoryLicense}');
    print('address es ${state.address}');
    try {
      await db.doc(id).update(transport);
      return ResponseData(isOk: true, menssage: 'isOk', data: null);
    } catch (e) {
      return ResponseData(isOk: false, menssage: e.toString(), data: null);
    }
  }
}
