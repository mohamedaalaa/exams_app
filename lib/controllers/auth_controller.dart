import 'package:exams/services/helper_functoins.dart';
import 'package:exams/utils/comon_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  RxBool isEmailSignupValid = false.obs;
  RxBool isPasswordSignupValid = false.obs;
  RxBool isEmailLoginValid = false.obs;
  RxBool isPasswordLoginValid = false.obs;
  RxBool isEmailFPValid = false.obs;
  RxBool isVisible = true.obs;
  RxBool isLoading = false.obs;
  RxBool isTeacher = true.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signOut(BuildContext context) async {
    try {
      isLoading(true);
      await auth.signOut();
      await HelperFunctions().saveUserLoggedInDetails(false);
    } on FirebaseAuthException catch (error) {
      displayMessage(error.toString(), context);
    } finally {
      isLoading(false);
    }
  }

  Future<UserCredential?> signupUser(
      String email, String password, BuildContext context) async {
    try {
      isLoading(true);
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await HelperFunctions().saveUserLoggedInDetails(true);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        displayMessage('The password provided is too weak.', context);
      } else if (e.code == 'email-already-in-use') {
        displayMessage('The account already exists for that email.', context);
      }
    } finally {
      isLoading(false);
    }
    return null;
  }

  Future<UserCredential?> loginUser(
      String email, String password, BuildContext context) async {
    try {
      isLoading(true);
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await HelperFunctions().saveUserLoggedInDetails(true);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displayMessage("No user found for that email.", context);
      } else if (e.code == 'wrong-password') {
        displayMessage("Wrong password provided for that user.", context);
      }
    } finally {
      isLoading(false);
    }
    return null;
  }

  Future resetPassword(String email, BuildContext context) async {
    try {
      isLoading(true);

      await FirebaseAuth.instance.sendPasswordResetEmail(email: "mhamedalaa462@gmail.com");
    } on FirebaseException catch (e) {
      displayMessage(e.toString(), context);
    } finally {
      isLoading(false);
      displayMessage("password reset link was sent", context);
    }
  }

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  void checkSignupEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    emailValid
        ? isEmailSignupValid.value = true
        : isEmailSignupValid.value = false;
  }

  void checkSignupPassword(String password) {
    (password.length > 5)
        ? isPasswordSignupValid.value = true
        : isPasswordSignupValid.value = false;
  }

  void checkLoginEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    emailValid
        ? isEmailLoginValid.value = true
        : isEmailLoginValid.value = false;
  }

  void checkLoginPassword(String password) {
    (password.length > 5)
        ? isPasswordLoginValid.value = true
        : isPasswordLoginValid.value = false;
  }

  void checkFPEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    emailValid ? isEmailFPValid.value = true : isEmailFPValid.value = false;
  }

  void toggleTeacher() {
    isTeacher.value = !isTeacher.value;
  }
}
