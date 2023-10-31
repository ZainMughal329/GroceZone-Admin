import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/controllers/menu_controllers.dart';
import 'package:groce_zone_admin/layout.dart';
import 'package:groce_zone_admin/pages/dashboard/controller.dart';
import 'package:groce_zone_admin/pages/inventory/addInventory/controller.dart';
import 'package:groce_zone_admin/pages/inventory/discountedItems/controller.dart';
import 'package:groce_zone_admin/pages/inventory/editInventory/all_items_edit/controller.dart';
import 'package:groce_zone_admin/pages/inventory/editInventory/edit_details_screen/controller.dart';
import 'package:groce_zone_admin/pages/orders/widgets/order_items/controller.dart';
import 'package:groce_zone_admin/pages/orders/widgets/orders_detail/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCY-ghq3F_ohujHV_NQ2ENn8aP4YmJo2j4",
        authDomain: "grocery-app-bed5a.firebaseapp.com",
        projectId: "grocery-app-bed5a",
        storageBucket: "grocery-app-bed5a.appspot.com",
        messagingSenderId: "287411568147",
        appId: "1:287411568147:web:f5bcd21c4b1868117309e6",
        measurementId: "G-LBXWDB21TC"),
  );
  Get.put(SideMenuController());
  Get.put(OrderDetailController());
  Get.put(OrderItemsController());
  Get.put(AddItemController());
  Get.put(DashBoardController());
  Get.put(EditItemController());
  Get.put(EditScreenController());
  Get.put(DiscountedItemController());

  // await FirebaseAppWeb
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        ///kldsajflksjdflksdj
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SiteLayout(),
    );
  }
}

