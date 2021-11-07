// ignore_for_file: use_key_in_widget_constructors

import 'package:belajar_firebase_flutter/app/controllers/auth_controller.dart';
import 'package:belajar_firebase_flutter/app/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot.data);
          return GetMaterialApp(
            title: "Application",
            initialRoute:
                (snapshot.data != null) ? AppPages.INITIAL : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        } else {
          return LoadingView();
        }
      },
    );
  }
}
