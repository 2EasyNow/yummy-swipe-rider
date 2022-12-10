import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/config/app_information.dart';
import 'package:sizer/sizer.dart';
import 'app/data/services/dependency_injection.dart';
import 'app/data/services/fcm.service.dart';
import 'app/data/services/translations_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/ui/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // initialize the firebase App
  await Firebase.initializeApp();
  final fcmService = await Get.putAsync<FCMService>(() => FCMService().init(), permanent: true);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await fcmService.requestPermissions();
  // FirebaseMessaging.onBackgroundMessage(fcmService.firebaseMessagingBackgroundHandler);

  DependecyInjection.init();
  while (!Get.isRegistered<ThemeController>()) {}

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return const MyApp();
      },
    ),
  );
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GetStorage.init();
//   // initialize the firebase App
//   await Firebase.initializeApp();
//   DependecyInjection.init();
//   while (!Get.isRegistered<ThemeController>()) {}

//   runApp(
//     Sizer(
//       builder: (context, orientation, deviceType) {
//         return const MyApp();
//       },
//     ),
//   );
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppInformation.title,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      translations: Translation(),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      initialRoute: AppRoutes.SPLASH,
      unknownRoute: AppPages.unknownRoutePage,
      getPages: AppPages.pages,
    );
  }
}
