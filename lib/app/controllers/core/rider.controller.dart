import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intelligent_food_delivery/app/firestore/rider/rider.dart';

class RiderController extends GetxController {
  StreamSubscription<RiderDocumentSnapshot>? currentRiderDocListener;

  Rx<RiderDocumentSnapshot>? riderDocumentSnapshot;

  String? get currentCustomerId => FirebaseAuth.instance.currentUser?.uid;

  RiderDocumentReference get currentRiderReference => riderRef.doc(currentCustomerId);

  Rider? get currentRider => riderDocumentSnapshot?.value.data;

  Stream<RiderDocumentSnapshot> get onRiderDataChange {
    return currentRiderReference.snapshots();
  }

  @override
  onInit() {
    super.onInit();
    listenToCustomerDoc();
  }

  Future<bool> get hasRiderDocCreated async => (await currentRiderReference.get()).exists;

  Future createCustomerDoc(Rider customer) async {
    await currentRiderReference.set(customer);
    listenToCustomerDoc();
  }

  listenToCustomerDoc() {
    if (FirebaseAuth.instance.currentUser == null || currentRiderDocListener != null) return;
    hasRiderDocCreated.then((value) {
      if (value) {
        currentRiderDocListener = onRiderDataChange.listen((snapshot) {
          if (riderDocumentSnapshot == null) {
            riderDocumentSnapshot = snapshot.obs;
          } else {
            riderDocumentSnapshot!.value = snapshot;
          }
        });
      }
    });
  }

  stopCustomerDocListener() {
    currentRiderDocListener?.cancel();
    riderDocumentSnapshot = null;
  }

  @override
  void onClose() {
    super.onClose();
    if (currentRiderDocListener != null) currentRiderDocListener!.cancel();
    riderDocumentSnapshot = null;
  }

  Future<bool> isRiderExist(String phoneNumber) async {
    final customer = await riderRef.wherePhone(isEqualTo: phoneNumber).limit(1).get();
    return customer.docs.isNotEmpty;
  }
}
