import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final viewSigInCurrentPovider =
    StateProvider.autoDispose((ref) => ViewSigIn.signIn);

final userPovider = StateProvider<String>((ref) => 'dash128');
final passwordPovider = StateProvider<String>((ref) => 'ABC123');
final rememberUserPovider = StateProvider<bool>((ref) => false);

enum ViewSigIn { signIn, selectedTypeUser, tutorial }

Future<String> signIn(email, password) async {
  try {
    var f = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
    } else if (e.code == 'wrong-password') {
    } else {}
  }
  return '';
}
