import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stotppub/src/core/data/dto/response_data.dart';
import 'package:stotppub/src/core/data/entity/entity.dart';

StateProvider<bool> isLoadingPageRegisterClient =
    StateProvider<bool>((ref) => false);

final registerClientStateNotifierProvider =
    StateNotifierProvider<RegisterClientFormNotifier, RegisterClientFormEntity>(
  (ref) => RegisterClientFormNotifier(
    RegisterClientFormEntity(
      name: '',
      lastName: '',
      dni: '',
      phone: '',
      address: '',
      email: '',
      password: '',
    ),
  ),
);

class RegisterClientFormNotifier
    extends StateNotifier<RegisterClientFormEntity> {
  RegisterClientFormNotifier(super.state);

  setName(String value) {
    final newState = state.copy(name: value);
    state = newState;
  }

  setLastName(String value) {
    final newState = state.copy(lastName: value);
    state = newState;
  }

  setPhone(String value) {
    final newState = state.copy(phone: value);
    state = newState;
  }

  setDni(String value) {
    final newState = state.copy(dni: value);
    state = newState;
  }

  setAddress(String value) {
    final newState = state.copy(address: value);
    state = newState;
  }

  setEmail(String value) {
    final newState = state.copy(email: value);
    state = newState;
  }

  setPassword(String value) {
    final newState = state.copy(password: value);
    state = newState;
  }

  cleanData() {
    state = RegisterClientFormEntity(
      id: null,
      name: '',
      lastName: '',
      phone: '',
      dni: '',
      address: '',
      email: '',
      password: '',
    );
  }

  Future<ResponseData> addData() async {
    ResponseData<User> createUser =
        await createAccount(state.email, state.password);

    if (!createUser.isOk) {
      return ResponseData(
          isOk: false, menssage: createUser.menssage, data: null);
    }

    String id = createUser.data!.uid;
    CollectionReference db = FirebaseFirestore.instance.collection("clientes");
    CollectionReference dbType =
        FirebaseFirestore.instance.collection("userType");
    final client = <String, dynamic>{
      "id": id,
      "name": state.name,
      "lastName": state.lastName,
      "phone": state.phone,
      "dni": state.dni,
      "address": state.address,
      "email": state.email,
      "password": state.password,
      "type": "client",
    };

    try {
      await dbType.doc(id).set({
        "idUser": id,
        "type": "client",
      });
      var data = await db.doc(id).set(client);
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
    CollectionReference db = FirebaseFirestore.instance.collection("clientes");

    final client = <String, dynamic>{
      "name": state.name,
      "lastName": state.lastName,
      "phone": state.phone,
      "address": state.address,
    };

    print('name es ${state.name}');
    print('lastName es ${state.lastName}');
    print('phone es ${state.phone}');
    print('address es ${state.address}');
    // return ResponseData(isOk: false, menssage: 'dbdb');

    try {
      await db.doc(id).update(client);
      return ResponseData(isOk: true, menssage: 'isOK', data: null);
    } catch (e) {
      return ResponseData(isOk: false, menssage: e.toString());
    }
  }
}
