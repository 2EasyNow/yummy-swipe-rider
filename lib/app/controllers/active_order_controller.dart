import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intelligent_food_delivery/app/data/services/fcm.service.dart';
import 'package:intelligent_food_delivery/app/firestore/customer/app_user.dart';
import 'package:intelligent_food_delivery/app/firestore/food_order/food_order.dart';
import 'package:intelligent_food_delivery/app/firestore/rider/rider.dart';
import 'package:intelligent_food_delivery/app/utils/snackbars.dart';
import '../firestore/restaurant/restaurant.dart';
import 'core/rider.controller.dart';
import 'package:geocoding/geocoding.dart';

class ActiveOrderController extends GetxController {
  bool isFeteched = false;
  FoodOrder? order;
  late final initialCameraPos;
  Set<Marker> markers = {};
  GoogleMapController? mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  String? address;

// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};
  AppUser? customer;
  Restaurant? restauratn_details;

  @override
  void onInit() {
    super.onInit();
    fetchOrder();
    final riderController = Get.find<RiderController>();
    initialCameraPos = CameraPosition(
      target: riderController.currentRider!.location!,
      zoom: 15,
    );
  }

  fetchOrder() async {
    final rider = (await riderRef.doc(FirebaseAuth.instance.currentUser!.uid).get()).data!;
    if (rider.currentOrderId.isEmpty) {
      isFeteched = true;
      update();
      return;
    }
    order = (await foodOrdersRef.doc(rider.currentOrderId).get()).data!;
    updateMarkers();
    findAddress();
    findDetails();
    isFeteched = true;
    update();
  }

  findAddress() async {
    late LatLng latlng;
    if (order!.status == OrderStatus.cooking) {
      latlng = order!.restaurantLocation;
    }
    if (order!.status == OrderStatus.pickedUpByRider) {
      latlng = order!.customerLocation;
    }
    List<Placemark> placemarks = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
    Placemark place = placemarks[0];
    address = "${place.subLocality}, ${place.locality}";
    update();
  }

  updateMarkers() {
    if (order == null) return;
    if (order!.status == OrderStatus.cooking) {
      markers.add(
        Marker(
          markerId: const MarkerId('Restaurant'),
          infoWindow: const InfoWindow(title: "Restaurant"),
          position: order!.restaurantLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }
    if (order!.status == OrderStatus.pickedUpByRider) {
      markers.add(Marker(
        markerId: const MarkerId('customer'),
        infoWindow: const InfoWindow(title: "Customer"),
        position: order!.customerLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }
  }

  setIntialCameraZoom() {
    final riderController = Get.find<RiderController>();
    final startLat = riderController.currentRider!.location!.latitude;
    final startLng = riderController.currentRider!.location!.longitude;
    var destinationLat, destinationLng;
    if (order!.status == OrderStatus.cooking) {
      destinationLat = order!.restaurantLocation.latitude;
      destinationLng = order!.restaurantLocation.longitude;
    } else {
      destinationLat = order!.customerLocation.latitude;
      destinationLng = order!.customerLocation.longitude;
    }

    double miny = (startLat <= destinationLat) ? startLat : destinationLat;
    double minx = (startLng <= destinationLng) ? startLng : destinationLng;
    double maxy = (startLat <= destinationLat) ? destinationLat : startLat;
    double maxx = (startLng <= destinationLng) ? destinationLng : startLng;

    double southWestLatitude = miny;
    double southWestLongitude = minx;

    double northEastLatitude = maxy;
    double northEastLongitude = maxx;

// Accommodate the two locations within the
// camera view of the map

    mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        100.0,
      ),
    );
    _createPolylines(startLat, startLng, destinationLat, destinationLng);
  }

  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyCbWKk9loepkI0FMr3b5DKuBd7eijHTgAU', // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
    update();
  }

  findDetails() async {
    if (order!.status == OrderStatus.cooking) {
      restauratn_details = (await userRef.doc(order!.restaurantId).get()).data!;
    } else {
      customer = (await customerRef.doc(order!.customerId).get()).data!;
    }
    update();
  }

  onDelivered() {
    // Ask for confirmation
    Get.defaultDialog(
      title: "Confirm",
      middleText: "Are you sure you have delivered the order?",
      // buttonColor: Colors.red,
      contentPadding: const EdgeInsets.all(20),
      cancel: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        onPressed: () {
          Get.back();
        },
        child: const Text(
          'No',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      confirm: TextButton(
        onPressed: () async {
          await foodOrdersRef.doc(order!.id).set(
                order!.copyWith(
                  status: OrderStatus.delivered,
                ),
              );
          await riderRef.doc(order!.riderId).update(
                currentOrderId: '',
              );
          await FCMService().sendPushMessage(
            'Order Delivered',
            'Successfully Delivered the order',
            customer!.fcmTokens,
          );
          Get.back();
          Get.back();
          showAppSnackBar('Order Delivered', "Successfully updated order status");
        },
        child: const Text('Yes'),
      ),
      onConfirm: () async {
        foodOrdersRef.doc(order!.id).set(
              order!.copyWith(
                status: OrderStatus.delivered,
              ),
            );
        // Get.back();
        // Get.back();
      },
      onCancel: () {
        // Get.back();
      },
    );
  }
}
