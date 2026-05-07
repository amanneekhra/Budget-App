import 'package:budgetapp/Components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:logger/logger.dart';

final userLogin = ChangeNotifierProvider.autoDispose<UserLogin>(
  (ref) => UserLogin(),
);
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(userLogin).authStateChange;
});

class UserLogin extends ChangeNotifier {
  List earning = [];
  List earningName = [];
  List expensesName = [];
  List expenses = [];
  final _auth = FirebaseAuth.instance;
  late final logger = Logger();
  //bool isLoggedIn = false;
  bool isObscure = true;
  final localKey = GlobalKey<FormState>();
  CollectionReference UserReference = FirebaseFirestore.instance.collection(
    'users',
  );
  Stream<User?> get authStateChange => _auth.authStateChanges();
  /*Future<void> checkLogIn() async {
    await _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
      }
    });
    notifyListeners();
  }*/

  obsureText() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> signInUsingEmailAndPassword({
    required BuildContext context,
    required String Email,
    required String Password,
  }) async {
    await _auth
        .createUserWithEmailAndPassword(email: Email, password: Password)
        .then((onValue) => logger.d('Sign-in Completed'))
        .onError((error, StackTrace) {
          logger.d('Registration Error ${error}');
          dialogBox(context, error.toString());
        });
  }

  Future<void> logInUsingEmailAndPassword({
    required BuildContext context,
    required String Email,
    required String Password,
  }) async {
    _auth
        .signInWithEmailAndPassword(email: Email, password: Password)
        .then((Value) => logger.d('Log_in Successful'))
        .onError((error, StackTrace) {
          logger.d('Registration Error ${error}');
          dialogBox(context, error.toString());
        });
  }

  Future<void> SignInWithGoogleWeb(BuildContext context) async {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    _auth
        .signInWithPopup(googleAuthProvider)
        .then((Value) => logger.d('signed in with Google'))
        .onError((error, StackTrace) {
          logger.d('User Id Is Not Empty=${_auth.currentUser!.uid.isNotEmpty}');
          dialogBox(context, error.toString());
        });
  }

  Future<void> SignInGoogleMobile(BuildContext context) async {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate()
        .catchError((error) {
          logger.d(error);
          dialogBox(context, error.toString());
        });
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
    );
    _auth
        .signInWithCredential(credential)
        .then((value) => logger.d('sign_in with google successful'))
        .onError((error, StackTrace) {
          dialogBox(context, error.toString());
        });
  }

  Future<void> SignOut() async {
    await _auth.signOut();
  }

  InkWell AddIncomeExpenseDialogBox(
    BuildContext context, {
    required String name,
    required TextEditingController nameController,
    required TextEditingController AmountController,
  }) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(15.0),
              elevation: 5.0,
              constraints: BoxConstraints(minHeight: 350.0, minWidth: 350.0),
              backgroundColor: Colors.white,

              title: Form(
                key: localKey,
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    SizedBox(height: 20.0),
                    textField(
                      width: 270.0,
                      validator: (text) {
                        if (text.toString().isEmpty) {
                          return 'Fill all blanks';
                        }
                      },
                      text: '${name} Name',
                      icon: Icons.monetization_on,
                      controller: nameController,
                    ),
                    SizedBox(height: 30.0),
                    textField(
                      width: 270.0,
                      validator: (text) {
                        if (text.toString().isEmpty) {
                          return 'Fill all blanks';
                        }
                      },
                      text: '${name} Amount',
                      icon: Icons.monetization_on,
                      controller: AmountController,
                      keyBoardType: TextInputType.number,
                      digitOnly: true,
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: .spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (localKey.currentState!.validate()) {
                              UserReference.doc(_auth.currentUser!.uid)
                                  .collection('${name}')
                                  .add({
                                    'Name': nameController.text,
                                    'Amount': AmountController.text,
                                  })
                                  .onError(
                                    (error, StackTrace) =>
                                        dialogBox(context, error.toString()),
                                  );
                              Navigator.pop(context);
                            }
                          },
                          child: clickableButton(
                            width: 100.0,
                            height: 50.0,
                            text: 'Add ${name}',
                            textFontSize: 14.0,
                            textFontWeight: .normal,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: clickableButton(
                            width: 100.0,
                            height: 50.0,
                            text: 'Cancle',
                            textFontSize: 14.0,
                            textFontWeight: .normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: clickableButton(
        width: 120.0,
        height: 50.0,
        textFontSize: 14.0,
        textFontWeight: .normal,
        text: 'Add ${name}',
        color: Colors.blueAccent.shade400,
      ),
    );
  }

  Future<void> GetExpenseFromFireStore() async {
    await for (var snapshot in UserReference.doc(
      _auth.currentUser!.uid,
    ).collection('Expense').snapshots()) {
      expensesName = [];
      expenses = [];
      for (var expense in snapshot.docs) {
        expensesName.add(expense.data()['Name']);
        expenses.add(expense.data()['Amount']);
        notifyListeners();
      }
    }
  }

  Future<void> getIncomeFromFirestore() async {
    await for (var snapshot in UserReference.doc(
      _auth.currentUser!.uid,
    ).collection('Income').snapshots()) {
      earningName = [];
      earning = [];
      for (var income in snapshot.docs) {
        earning.add(income.data()['Amount']);
        earningName.add(income.data()['Name']);
        notifyListeners();
      }
    }
  }

  Future<void> Reset() async {
    await UserReference.doc(
      _auth.currentUser!.uid,
    ).collection('Expense').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await UserReference.doc(
      _auth.currentUser!.uid,
    ).collection('Income').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    notifyListeners();
  }

  loginWithApple() {
    AppleAuthProvider authProvider = AppleAuthProvider();
    _auth.signInWithPopup(authProvider);
  }
}
