import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstorage/localstorage.dart';
import 'package:stotppub/src/core/presentacion/widgets/widgets.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

// TODO ver en perfil cliente
class ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    var colorPrimary = color.primary;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    );
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: FutureBuilder(
          future: findUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            print('---${snapshot.data?['name']}');
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                          child: Material(
                            child: Container(
                              child: Ink.image(
                                image: AssetImage(
                                    'assets/images/image_user_default2.png'),
                                // image: const NetworkImage(
                                //     'https://pub-static.fotor.com/assets/projects/pages/d5bdd0513a0740a8a38752dbc32586d0/fotor-03d1a91a0cec4542927f53c87e0599f6.jpg'),
                                width: 128,
                                height: 128,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 5,
                          child: ClipOval(
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              color: Colors.purpleAccent,
                              child: ClipOval(
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      color: Colors.amber,
                                      child: const Icon(Icons.edit))),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextFormFieldCustom1(
                      enabled: false,
                      label: 'Nombre',
                      initialValue: snapshot.data?['name'],
                    ),
                    const SizedBox(height: 15),
                    TextFormFieldCustom1(
                      enabled: false,
                      label: 'Email',
                      initialValue: snapshot.data?['email'],
                    ),
                    const SizedBox(height: 15),
                    TextFormFieldCustom1(
                      label: 'Celular',
                      initialValue: snapshot.data?['number'],
                    ),
                    const SizedBox(height: 15),
                    TextFormFieldCustom1(
                      label: 'Dirección',
                      initialValue: snapshot.data?['address'],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<Map<String, String>> findUser() async {
    try {
      final storage = LocalStorage('my_data.json');
      String id = await storage.getItem('idUser');
      String userType = await storage.getItem('userType') ?? '';
      FirebaseFirestore instanceDB = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> queryData;
      print('type: ${userType} - ${id}');
      if (userType == 'driver') {
        queryData = await instanceDB
            .collection('trasnportista')
            .limit(1)
            .where('id', isEqualTo: id)
            .get();
      } else {
        queryData = await instanceDB
            .collection('clientes')
            .limit(1)
            .where('id', isEqualTo: id)
            .get();
      }
      //Map<String, String>
      List<Map<String, String>> userInfo = queryData.docs.map((doc) {
        var number = '';
        if (userType == 'driver') {
          number = (doc['number'] ?? '') as String;
        } else {
          number = (doc['phone'] ?? '') as String;
        }
        print(doc);
        return {
          'name': (doc['name'] ?? '') as String,
          'lastName': (doc['lastName'] ?? '') as String,
          'address': (doc['address'] ?? '') as String,
          'number': number, //(doc['number'] ?? '') as String,
          'email': (doc['email'] ?? '') as String,
        };
      }).toList();

      // if(userInfo.isEmpty){

      // }
      print('userInfo ${userInfo[0]['name']}');

      return {
        'type': userType,
        'name': userInfo[0]['name'] ?? '---',
        'lastName': '',
        'phone': userInfo[0]['phone'] ?? '---',
        'number': userInfo[0]['number'] ?? '---',
        'dni': userInfo[0]['dni'] ?? '---',
        'ruc': userInfo[0]['ruc'] ?? '---',
        'address': userInfo[0]['address'] ?? '---',
        'email': userInfo[0]['email'] ?? '---',
      };
    } catch (e) {
      print('err ${e.toString()}');
      return {
        'type': 'userType',
        'name': 'Dash',
        'lastName': '',
        'phone': '980873988',
        'number': '980873988',
        'dni': '',
        'ruc': '',
        'address': 'Av. Aviación 5370 - San Borja',
        'email': 'cliente@gmail.com',
      };
    }
  }
}
