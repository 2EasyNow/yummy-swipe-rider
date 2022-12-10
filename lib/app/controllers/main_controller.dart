import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intelligent_food_delivery/app/controllers/core/rider.controller.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class MainController extends GetxController with WidgetsBindingObserver {
  StreamSubscription? locationChangeListener;

  MainController() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  onInit() {
    super.onInit();
    locationStream();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        if (locationChangeListener != null) {
          locationChangeListener!.cancel();
          locationChangeListener = null;
        }
      } else {
        final riderController = Get.find<RiderController>();
        if (locationChangeListener != null) locationChangeListener!.cancel();
        locationChangeListener = Location.instance.onLocationChanged.listen((event) {
          riderController.updateRiderCurrentLocation(event);
        });
      }
    });
  }

  locationStream() async {
    // await Permission.notification.request();
    var res = await Permission.locationWhenInUse.request();
    if (res.isGranted) {
      res = await Permission.locationAlways.request();
    }
    await enableBackgroundMode();
    // Location.instance.changeNotificationOptions(
    //   title: 'Location',
    // );
    Location.instance.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 5000,
      distanceFilter: 0,
    );
  }

  Future<bool> enableBackgroundMode() async {
    final location = Location.instance;
    bool _bgModeEnabled = await location.isBackgroundModeEnabled();
    if (_bgModeEnabled) {
      return true;
    } else {
      try {
        await location.enableBackgroundMode();
      } catch (e) {
        debugPrint(e.toString());
      }
      try {
        _bgModeEnabled = await location.enableBackgroundMode();
      } catch (e) {
        debugPrint(e.toString());
      }
      print(_bgModeEnabled); //True!
      return _bgModeEnabled;
    }
  }

  @override
  void dispose() {
    print("Disposing");
    final riderController = Get.find<RiderController>();
    // update active  to false
    print('apps: ${Firebase.apps.length}');
    print('Disposing');
    // riderController.currentRiderReference.update(active: false);
    // riderController.stopCustomerDocListener();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.detached:
        debugPrint("App Detached");
        break;
      case AppLifecycleState.resumed:
        debugPrint("App Resumed");
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
    }
    debugPrint('''
=============================================================
$state
=============================================================
''');
  }

  @override
  void onClose() {
    super.onClose();
  }
}


