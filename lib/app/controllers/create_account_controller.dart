import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intelligent_food_delivery/app/controllers/core/rider.controller.dart';
import 'package:intelligent_food_delivery/app/utils/bottom_sheets.dart';
import 'core/authentication.controller.dart';
import 'core/rider.controller.dart';
import '../firestore/rider/rider.dart';

enum CreateAccountState {
  info,
  verification,
  verificationSuccess,
  codeSent,
  codeVerification,
  codeVerifying,
  codeVerificationFailed,
  userCreation,
  userCreated,
  error,
}

class CreateAccountController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneNumberScopeNode = FocusScopeNode();
  // final emailController = TextEditingController();
  final cityController = TextEditingController();
  final ageController = GroupButtonController();
  final vehicleTypeController = TextEditingController();
  String ageCategory = '';

  String? get phoneNumber {
    final number = phoneController.text.replaceAll('-', '');
    return '+923$number';
  }

  String? _verificationId;
  int? _forceResendCode;

  final smsCodeController = TextEditingController();

  final createAccountState = CreateAccountState.info.obs;

  onCreateAccountWithPhoneNumber() async {
    if (!formKey.currentState!.validate()) return;
    // check if the user is already registered

    createAccountState.value = CreateAccountState.verification;
    final authController = Get.find<AuthenticationController>();
    // authController.createUserWithPhone(email, password, name)

    authController.signInWithPhoneNumber(
      phoneNumber!,
      onCompleteVerification: () {
        createAccountState.value = CreateAccountState.userCreation;
        // Next Step is to Save User Data
      },
      onCodeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        _forceResendCode = forceResendingToken;
        createAccountState.value = CreateAccountState.codeSent;
        // Next Step is ask user to enter code
      },
    );
  }

  onVerifyCode() async {
    final authController = Get.find<AuthenticationController>();
    try {
      // createAccountState.value = CreateAccountState.codeVerifying;
      await authController.verifyCode(smsCodeController.text, _verificationId!);
      createAccountState.value = CreateAccountState.userCreation;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        createAccountState.value = CreateAccountState.codeVerificationFailed;
      } else {
        createAccountState.value = CreateAccountState.error;
      }
    }
  }

  void saveUserData() async {
    final riderController = Get.find<RiderController>();
    final rider = Rider(
      name: nameController.text,
      phone: phoneNumber!,
      city: cityController.text,
      age: ageCategory,
      vehicleType: vehicleTypeController.text,
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );
    await riderController.createCustomerDoc(rider);
    createAccountState.value = CreateAccountState.userCreated;
  }
}
