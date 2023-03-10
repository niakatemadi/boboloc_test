import 'package:boboloc/pages/calendar_page.dart';
import 'package:boboloc/pages/car_details_page.dart';
import 'package:boboloc/pages/cars_list_page.dart';
import 'package:boboloc/pages/contact_us_page.dart';
import 'package:boboloc/pages/contract_form_page.dart';
import 'package:boboloc/pages/create_new_car_page.dart';
import 'package:boboloc/pages/navigation_page.dart';
import 'package:boboloc/pages/profile_page.dart';
import 'package:boboloc/pages/sign_in_page.dart';
import 'package:boboloc/pages/sign_up_page.dart';
import 'package:boboloc/pages/subscribments_page.dart';
import 'package:boboloc/pages/wrapper/wrapper_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return WrapperPage();
        },
      ),
      GoRoute(
        path: '/sign_in',
        builder: (BuildContext context, GoRouterState state) {
          return SignInPage();
        },
      ),
      GoRoute(
        path: '/sign_up',
        builder: (BuildContext context, GoRouterState state) {
          return SignUpPage();
        },
      ),
      GoRoute(
        path: '/cars_list',
        builder: (BuildContext context, GoRouterState state) {
          return CarsListPage();
        },
      ),
      GoRoute(
        path: '/navigation_page',
        builder: (BuildContext context, GoRouterState state) {
          return NavigationPage();
        },
      ),
      GoRoute(
        path: '/car_details',
        name: 'car_details',
        builder: (BuildContext context, GoRouterState state) {
          Map<String, String> currentCarDatas = state.queryParams;
          return CarDetailsPage(carDatas: currentCarDatas);
        },
      ),
      GoRoute(
        path: '/calendar_page',
        name: 'calendar_page',
        builder: (BuildContext context, GoRouterState state) {
          Map<String, String> currentCarDatas = state.queryParams;
          return CalendarPage();
        },
      ),
      GoRoute(
        path: '/car_contract_form',
        name: 'car_contract_form',
        builder: (BuildContext context, GoRouterState state) {
          Map<String, String> currentCarDatas = state.queryParams;
          return ContractFormPage(carDatas: currentCarDatas);
        },
      ),
      GoRoute(
        path: '/profile_page',
        name: 'profile_page',
        builder: (BuildContext context, GoRouterState state) {
          return const ProfilePage();
        },
      ),
      GoRoute(
        path: '/contact_page',
        name: 'contact_page',
        builder: (BuildContext context, GoRouterState state) {
          return ContactUsPage();
        },
      ),
      GoRoute(
        path: '/wrapper_page',
        builder: (BuildContext context, GoRouterState state) {
          return WrapperPage();
        },
      ),
      GoRoute(
        path: '/subscribment_page',
        builder: (BuildContext context, GoRouterState state) {
          return SubscribmentsPage();
        },
      ),
      GoRoute(
        path: '/add_new_car',
        builder: (BuildContext context, GoRouterState state) {
          return CreateNewCarPage();
        },
      )
    ],
  );

  routerDatas() {
    return _router;
  }
}
