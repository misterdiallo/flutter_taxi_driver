import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:taxi_driver_app/admin/dashboard.dart';
import 'package:taxi_driver_app/core/controllers/auth/auth_manager_controller.dart';
import 'package:taxi_driver_app/core/controllers/bottom_nav_controller.dart';
import 'package:taxi_driver_app/core/controllers/customer_data_controller.dart';
import 'package:taxi_driver_app/core/controllers/driver_data_controller.dart';
import 'package:taxi_driver_app/core/controllers/fisrt_run/first_run_controller.dart';
import 'package:taxi_driver_app/core/controllers/app/navigation_provider.dart';
import 'package:taxi_driver_app/core/controllers/notification/drawer.dart';
import 'package:taxi_driver_app/core/services/first_run/first_run_check_service.dart';
import 'package:taxi_driver_app/core/services/first_run/skip_splash_middleware.dart';
import 'admin/constant.dart';
import 'core/controllers/app/app_controller.dart';
import 'core/controllers/auth/login_controller.dart';
import 'core/controllers/controllers.dart';
import 'core/controllers/notification/notification_controller.dart';
import 'core/controllers/users/user_controller.dart';
import 'core/controllers/users/user_provider.dart';
import 'core/services/auth/auth_service.dart';
import 'core/services/auth/user_service.dart';
import 'router.dart';
import 'ui/styles/theme.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => UserServices());
}

instanceControllers() async {
  Get.put(FirstRunCheckController());
  Get.put(UserProvider());
  Get.put(AppController());
  Get.put(UserController());
  Get.put(AuthController());
  Get.put(NotificationDrawerController());
  Get.put(BottomNavigationBarController());
  Get.put(NotificationController());
  Get.put(LoginController());
  Get.put(DriverDataController());
  Get.put(CustomerDataController());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => FirstRunCheckService().init());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await instanceControllers();
  setupLocator();
  // runApp(MaterialApp(
  //   title: 'Flutter Responsive Dashboard',
  //   debugShowCheckedModeBanner: false,
  //   themeMode: ThemeMode.light,
  //   // theme: ThemeData(
  //   //     primaryColor: MaterialColor(
  //   //       primaryColorCode,
  //   //       <int, Color>{
  //   //         50: const Color(primaryColorCode).withOpacity(0.1),
  //   //         100: const Color(primaryColorCode).withOpacity(0.2),
  //   //         200: const Color(primaryColorCode).withOpacity(0.3),
  //   //         300: const Color(primaryColorCode).withOpacity(0.4),
  //   //         400: const Color(primaryColorCode).withOpacity(0.5),
  //   //         500: const Color(primaryColorCode).withOpacity(0.6),
  //   //         600: const Color(primaryColorCode).withOpacity(0.7),
  //   //         700: const Color(primaryColorCode).withOpacity(0.8),
  //   //         800: const Color(primaryColorCode).withOpacity(0.9),
  //   //         900: const Color(primaryColorCode).withOpacity(1.0),
  //   //       },
  //   //     ),
  //   //     scaffoldBackgroundColor: const Color(0xFF171821),
  //   //     fontFamily: 'IBMPlexSans',
  //   //     brightness: Brightness.dark),
  //   home: DashBoard(),
  // ));
  runApp(
    OKToast(
      child: ChangeNotifierProvider(
        create: (BuildContext context) => NavigationProvider(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          onGenerateRoute: onGenerateRoute,
          navigatorObservers: const [
            // GetObserver(SkipSplashMiddleWare.observer), // Attach middleware observer
          ],
          theme: ThemeScheme.light(),
          darkTheme: ThemeScheme.dark(),
          themeMode:
              appController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          unknownRoute: getRoutes.last,
          getPages: getRoutes,
          defaultTransition: Transition.fade,
          initialRoute: InitialRoute,
          // initialRoute: DriverRoute,
        ),
      ),
    ),
  );
}
