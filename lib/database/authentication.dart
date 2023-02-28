import 'package:boboloc/models/user_connexion_model.dart';
import 'package:boboloc/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypt/crypt.dart';

class Authentication {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserConnexionData _userFromFirebaseUser(User user) {
    return UserConnexionData(userId: user.uid);
  }

  // Auth change user stream

  Stream<UserConnexionData> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  // This function add user in "users" collection of firestore firebase database
  createUser(UserModel user) async {
    db.collection("users").add({
      'userId': user.uid,
      'name': user.name,
      'firstName': user.firstName,
      'mail': user.email,
      'password': user.password,
      'city': user.city,
      'adresse': user.adresse,
      'company_name': user.companyName
    }).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  signUp(UserModel user) async {
    try {
      print('mdp in signUp');
      print(user.password);
      final passwordCrypted = Crypt.sha256(user.password,
              rounds: 10000, salt: 'crypterparniakatemadi')
          .toString();
      print('inscription mdp');
      print(passwordCrypted);
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: passwordCrypted,
      );

      user.uid = credential.user!.uid;
      user.password = passwordCrypted;

      createUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signIn({required String email, required String password}) async {
    try {
      print('mdp in signIn');
      print(password);
      final passwordCrypted =
          Crypt.sha256(password, rounds: 10000, salt: 'crypterparniakatemadi')
              .toString();
      print('connexion mdp !');
      print(passwordCrypted);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: passwordCrypted);

      var userId = credential.user!.uid;
      return userId;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
