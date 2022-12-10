import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intelligent_food_delivery/app/firestore/rider/rider.dart';
import 'package:location/location.dart';

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
          FirebaseMessaging.instance.getToken().then((value) {
            if (!currentRider!.fcmTokens.contains(value)) {
              currentRiderReference.update(fcmTokensFieldValue: FieldValue.arrayUnion([value]));
            }
          });
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

  void updateRiderCurrentLocation(LocationData locationData) {
    if (riderDocumentSnapshot == null) return;
    var updateLocation = true;
    if (riderDocumentSnapshot!.value.data!.location != null) {
      final distance = calculateDistance(
        riderDocumentSnapshot!.value.data!.location!.latitude,
        riderDocumentSnapshot!.value.data!.location!.longitude,
        locationData.latitude!,
        locationData.longitude!,
      );
      if (distance < 10) {
        updateLocation = false;
      }
    }
    if (updateLocation) {
      currentRiderReference.set(
        riderDocumentSnapshot!.value.data!.copyWith(
          location: LatLng(locationData.latitude!, locationData.longitude!),
        ),
      );
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
