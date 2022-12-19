import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controllers/active_order_controller.dart';
import '../../../firestore/food_order/food_order.dart';

class ActiveOrderPage extends GetView<ActiveOrderController> {
  const ActiveOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Active Order',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      extendBodyBehindAppBar: false,
      body: GetBuilder<ActiveOrderController>(
        builder: (context) {
          if (!controller.isFeteched) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.order == null) {
            return const Center(
              child: Text('No Active Order'),
            );
          }
          return Column(
            children: [
              // Show user address, phone number name etc
              if (controller.order!.status == OrderStatus.cooking)
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Restaurant Name: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(controller.restauratn_details?.name ?? ''),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Restaurant Phone: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(controller.restauratn_details?.phone ?? ''),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Restaurant Address: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(controller.address ?? ''),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              if (controller.order!.status == OrderStatus.pickedUpByRider)
                SizedBox(
                  // height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Customer Name: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(controller.customer?.name ?? ''),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Customer Phone: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(controller.customer?.phone ?? ''),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Customer Address: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(controller.address ?? ''),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              'Total Bill:   Rs. ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(controller.order!.totalBill.toString()),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: controller.onDelivered,
                          child: Text('Delivered'),
                        ),
                      ],
                    ),
                  ),
                ),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: controller.initialCameraPos,
                  polylines: Set.from(controller.polylines.values),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  markers: controller.markers,
                  onMapCreated: (GoogleMapController mapController) {
                    controller.mapController = mapController;
                    controller.setIntialCameraZoom();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
