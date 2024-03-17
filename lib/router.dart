// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/admin/dashboard.dart';
import 'package:uuid/uuid.dart';

import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/services/auth/auth_middleware.dart';
import 'package:taxi_driver_app/core/services/first_run/skip_splash_middleware.dart';
import 'package:taxi_driver_app/dispatcher.dart';
import 'package:taxi_driver_app/ui/screens/CUSTOMER/destination_view.dart';
import 'package:taxi_driver_app/ui/screens/CUSTOMER/home_page_customer.dart';
import 'package:taxi_driver_app/ui/screens/CUSTOMER/ride_detail_page_customer.dart';
import 'package:taxi_driver_app/ui/screens/CUSTOMER/searching_car_page_customer.dart';
import 'package:taxi_driver_app/ui/screens/CUSTOMER/suggested_rides_page_customer.dart';
import 'package:taxi_driver_app/ui/screens/DRIVER/home_page_driver.dart';
import 'package:taxi_driver_app/ui/screens/DRIVER/ride_detail/ride_main_page.dart';
import 'package:taxi_driver_app/ui/screens/error_page.dart';

import 'core/models/ride_model.dart';
import 'core/services/car_service.dart';
import 'ui/screens/auth/login.dart';
import 'ui/screens/auth/otp_verification.dart';
import 'ui/screens/auth/phone_registration.dart';
import 'ui/screens/auth/register.dart';
import 'ui/screens/auth/unauth.dart';
import 'ui/screens/chat/chat_rider.dart';
import 'ui/screens/country_select.dart';
import 'ui/screens/favorite_place/favorites.dart';
import 'ui/screens/favorite_place/update_favorite.dart';
import 'ui/screens/payment/add_card.dart';
import 'ui/screens/payment/payment.dart';
import 'ui/screens/profile/profile.dart';
import 'ui/screens/profile/update_information.dart';
import 'ui/screens/promotions/promotions.dart';
import 'ui/screens/ride_history/my_rides.dart';
import 'ui/screens/splash/splash_stepper.dart';

// Routes
const String InitialRoute = "/";
const String SplashRoute = "/onboarding";
const String UnAuthenticatedPageRoute = "/unauth";
const String HomepageRoute = "/homepage";
const String CustomerRoute = "/customer";
// DRIVER
const String DriverRoute = "/driver";
const String DriverRideDetailsRoute = "/ride-details-driver";
// ........

// .... ADMIN...
const String AdminRoute = "/admin";

// ...........
const String RegisterRoute = "/register";
const String LoginRoute = "/login";
const String PhoneRegisterRoute = "/phone-register";
const String OtpVerificationRoute = "/otp-verification";
const String UpdateInformationRoute = "/update-information";
const String SelectCountryRoute = "/country-select";
const String DestinationRoute = "/destination";
const String ProfileRoute = "/profile";
const String PaymentRoute = "/payment";
const String AddCardRoute = "/addCard";
const String ChatRiderRoute = "/chatRider";
const String FavoritesRoute = "/favorite";
const String UpdateFavoritesRoute = "/update-favorite";
const String PromotionRoute = "/promotion";
const String SuggestedRidesRoute = "/suggested-route";
const String MyRidesRoute = "/my-rides";
const String SearchingCarRoute = "/searching-car";
const String WaitingRideRoute = "/waiting-ride";
const String ErrorRoute = "/error";

// Router
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case InitialRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const Dispatcher());
    //
    case AdminRoute:
      return MaterialPageRoute(builder: (BuildContext context) => DashBoard());

    //
    case DriverRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const HomePageDriver());
    case DriverRideDetailsRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const RideDetails());

    //
    case SplashRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => WalkThrough());
    case RegisterRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const Register());
    case LoginRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Login());
    case PhoneRegisterRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const PhoneRegistration());
    case OtpVerificationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const OtpVerification());
    case UpdateInformationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const UpdateInformation());
    case SelectCountryRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const SelectCountry());
    case HomepageRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const HomepageCustomer());
    case DestinationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const DestinationViewCustomer());
    case UnAuthenticatedPageRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const UnAuth());
    case ProfileRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const Profile());
    case PaymentRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const Payment());
    case AddCardRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const AddCard());
    case ChatRiderRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const ChatRider());
    case FavoritesRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Favorites());
    case PromotionRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const Promotions());
    case UpdateFavoritesRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const UpdateFavorite());
    case SuggestedRidesRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const SuggestedRides());
    case MyRidesRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const MyRides());
    case SearchingCarRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const SearchingCar());
    case ErrorRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const ErrorPage());
    case WaitingRideRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => RideDetailsCustomer(
                ride: RideModel(
                  rideId: const Uuid().v4(),
                  user: authController.getUserModel()!,
                  car: carList[0],
                  driver: carList[0].user,
                  fare: "55 RMB",
                  endTime: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      DateTime.now().hour,
                      DateTime.now().minute + 55),
                  startTime: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      DateTime.now().hour,
                      DateTime.now().minute + 5),
                  rideOriginPlace: PlaceModel(
                    placeId: "21",
                    name: "Linyi University",
                    address: "789 University Avenue, Linyi, Shandong",
                    latitude: 35.0526,
                    longitude: 118.3421,
                    description: "A renowned educational institution in Linyi.",
                    typePlace: "University",
                    phoneNumber: null,
                    website: "https://www.lyu.edu.cn",
                  ),
                  rideEndPlace: PlaceModel(
                    placeId: "20",
                    name: "Rizhao Seaside Park",
                    address: "333 Coastal Promenade, Rizhao, Shandong",
                    latitude: 35.4164,
                    longitude: 119.5152,
                  ),
                  rideStatus: RideStatus.pending,
                  createdAt: DateTime.now(),
                ),
              ));
    default:
      return MaterialPageRoute(
          builder: (BuildContext context) => const Dispatcher());
  }
}

final getRoutes = [
  GetPage(
    name: SplashRoute,
    page: () => WalkThrough(),
  ),
  GetPage(
    name: InitialRoute,
    page: () => const Dispatcher(),
    middlewares: [
      SkipSplashMiddleWare(priority: 0),
      AuthMiddleware(priority: 1),
    ],
  ),
  GetPage(
    name: HomepageRoute,
    page: () => const HomepageCustomer(),
  ),
  //
  GetPage(
    name: DriverRoute,
    page: () => const HomePageDriver(),
  ),
  GetPage(
    name: AdminRoute,
    page: () => DashBoard(),
  ),
  GetPage(
    name: DriverRideDetailsRoute,
    page: () => const RideDetails(),
  ),
  //
  GetPage(
    name: CustomerRoute,
    page: () => const HomepageCustomer(),
  ),
  GetPage(name: DestinationRoute, page: () => const DestinationViewCustomer()),
  GetPage(name: PaymentRoute, page: () => const Payment()),
  GetPage(name: FavoritesRoute, page: () => Favorites()),
  GetPage(name: ChatRiderRoute, page: () => const ChatRider()),
  GetPage(name: ProfileRoute, page: () => const Profile()),
  GetPage(name: AddCardRoute, page: () => const AddCard()),
  GetPage(name: PromotionRoute, page: () => const Promotions()),
  GetPage(name: UpdateFavoritesRoute, page: () => const UpdateFavorite()),
  GetPage(name: SuggestedRidesRoute, page: () => const SuggestedRides()),
  GetPage(name: MyRidesRoute, page: () => const MyRides()),
  GetPage(name: SearchingCarRoute, page: () => const SearchingCar()),
  GetPage(
    middlewares: const [],
    name: WaitingRideRoute,
    page: () => RideDetailsCustomer(
      ride: RideModel(
        rideId: const Uuid().v4(),
        user: authController.getUserModel()!,
        car: carList[0],
        driver: carList[0].user,
        fare: "55 RMB",
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, DateTime.now().hour, DateTime.now().minute + 5),
        endTime: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute + 55),
        rideOriginPlace: PlaceModel(
          placeId: "21",
          name: "Linyi University",
          address: "789 University Avenue, Linyi, Shandong",
          latitude: 35.0526,
          longitude: 118.3421,
          description: "A renowned educational institution in Linyi.",
          typePlace: "University",
          phoneNumber: null,
          website: "https://www.lyu.edu.cn",
        ),
        rideEndPlace: PlaceModel(
          placeId: "20",
          name: "Rizhao Seaside Park",
          address: "333 Coastal Promenade, Rizhao, Shandong",
          latitude: 35.4164,
          longitude: 119.5152,
        ),
        rideStatus: RideStatus.pending,
        createdAt: DateTime.now(),
      ),
    ),
  ),
  GetPage(name: RegisterRoute, page: () => const Register()),
  GetPage(name: LoginRoute, page: () => Login()),
  GetPage(name: PhoneRegisterRoute, page: () => const PhoneRegistration()),
  GetPage(name: OtpVerificationRoute, page: () => const OtpVerification()),
  GetPage(name: UpdateInformationRoute, page: () => const UpdateInformation()),
  GetPage(name: SelectCountryRoute, page: () => const SelectCountry()),
  GetPage(name: UnAuthenticatedPageRoute, page: () => const UnAuth()),
  GetPage(name: ErrorRoute, page: () => const ErrorPage()),
];
