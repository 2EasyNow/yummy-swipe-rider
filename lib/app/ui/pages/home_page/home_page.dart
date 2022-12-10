import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intelligent_food_delivery/app/controllers/core/authentication.controller.dart';
import 'package:intelligent_food_delivery/app/controllers/core/rider.controller.dart';
import 'package:intelligent_food_delivery/app/ui/global_widgets/global_widgets.dart';
import 'package:intelligent_food_delivery/app/ui/theme/app_colors.dart';
import 'package:intelligent_food_delivery/app/ui/theme/text_theme.dart';
import 'package:sizer/sizer.dart';
import '../../../../assets/assets.gen.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);
  final _navigations = [
    _NavigationCardsModel(
      title: 'Active Order',
      image: Assets.images.burger.path,
      onTap: () {},
    ),
    _NavigationCardsModel(
      title: 'Category',
      image: Assets.images.deal.path,
      onTap: () {},
    ),
    _NavigationCardsModel(
      title: 'Profile',
      image: Assets.images.profile.path,
      onTap: () {},
    ),
    _NavigationCardsModel(
      title: 'Orders',
      image: Assets.images.profile.path,
      onTap: () {},
    ),
    _NavigationCardsModel(
      title: 'Logout',
      image: Assets.images.logout.path,
      onTap: () {
        Get.find<AuthenticationController>().logOut();
      },
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yummy Swipe'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: _navigations.map((item) {
          return Card(
            child: InkWell(
              onTap: item.onTap,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: item.image.endsWith('svg')
                          ? SvgPicture.asset(
                              item.image,
                              width: 80,
                            )
                          : Image.asset(
                              item.image,
                              width: 80,
                            ),
                    ),
                  ),
                  const Divider(),
                  Text(
                    item.title,
                    style: AppTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const VerticalSpacer(space: 8),
                ],
              ),
            ),
          );
        }).toList(),
      ).paddingSymmetric(horizontal: 12),
    );
  }
}

class _NavigationCardsModel {
  final String title;
  final String image;
  final Callback onTap;

  _NavigationCardsModel({
    required this.title,
    required this.image,
    required this.onTap,
  });
}
