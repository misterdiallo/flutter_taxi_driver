import 'package:taxi_driver_app/core/controllers/app/app_controller.dart';
import 'package:taxi_driver_app/core/controllers/auth/auth_manager_controller.dart';
import 'package:taxi_driver_app/core/controllers/auth/users_controller.dart';
import 'package:taxi_driver_app/core/controllers/bottom_nav_controller.dart';
import 'package:taxi_driver_app/core/controllers/fisrt_run/first_run_controller.dart';
import 'package:taxi_driver_app/core/controllers/notification/drawer.dart';
import 'package:taxi_driver_app/core/controllers/places_controller.dart';
import 'package:taxi_driver_app/core/db/supabase_controller.dart';

import 'auth/login_controller.dart';
import 'customer_data_controller.dart';
import 'driver_data_controller.dart';
import 'notification/notification_controller.dart';
import 'rides_controller.dart';

FirstRunCheckController firstRunCheckController =
    FirstRunCheckController.instance;
AppController appController = AppController.instance;
AuthController authController = AuthController.instance;
UserController userController = UserController.instance;
BottomNavigationBarController bottomNavigationBarController =
    BottomNavigationBarController.instance;
NotificationDrawerController notificationDrawerController =
    NotificationDrawerController.instance;
NotificationController notificationController = NotificationController.instance;
LoginController loginController = LoginController.instance;
CustomerDataController customerData = CustomerDataController.instance;
DriverDataController driverData = DriverDataController.instance;
SupabaseController supabaseController = SupabaseController.instance;
RidesController ridesController = RidesController.instance;
PlacesController placesController = PlacesController.instance;

List listLang = [
  {'name': "English", "code": "en"},
  {'name': "中文", "code": "cn"},
];
