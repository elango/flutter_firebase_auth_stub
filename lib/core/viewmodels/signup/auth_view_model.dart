import 'package:firebase_auth/firebase_auth.dart';
import 'package:dolphin_ride/core/viewmodels/base_view_model.dart';

class AuthViewModel extends BaseViewModel {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getUser(){
    return _auth.currentUser();
  }

  Stream<FirebaseUser> get onAuthStateChanged{
    return _auth.onAuthStateChanged;
  }

  Future logout() async {
    setBusy(true);
    var result = FirebaseAuth.instance.signOut();
    setBusy(false);
    return result;
  }

  Future<FirebaseUser> loginUser({String email, String password}) async {
    try {
      setBusy(true);
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // since something changed, let's notify the listeners...
      setBusy(false);
      return result.user;
    }  catch (e) {
      // throw the Firebase AuthException that we caught
      throw new AuthException(e.code, e.message);
    }
  }

}