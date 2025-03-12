import 'package:flutter/material.dart';

// Importaciones corregidas
import 'package:app_innova_delivery/presentation/screens/auth/login_screen.dart';
import 'package:app_innova_delivery/presentation/screens/home/home_screen.dart';
import 'package:app_innova_delivery/presentation/screens/profile/profile_screen.dart';
import 'package:app_innova_delivery/presentation/screens/profile/edit_profile_screen.dart';
import 'package:app_innova_delivery/presentation/screens/delivery/track_orders_screen.dart';
import 'package:app_innova_delivery/presentation/screens/delivery/order_history_screen.dart';
import 'package:app_innova_delivery/presentation/screens/delivery/location_screen.dart';
import 'package:app_innova_delivery/presentation/screens/settings/settings_screen.dart';
import 'package:app_innova_delivery/presentation/screens/notifications/notifications_screen.dart';
import 'package:app_innova_delivery/presentation/screens/reports/report_issue_screen.dart';
import 'package:app_innova_delivery/presentation/screens/landing/landing_screen.dart';
import 'package:app_innova_delivery/presentation/screens/splash/splash_screen.dart';
import 'package:app_innova_delivery/presentation/screens/orders/orders_screen.dart';
import 'package:app_innova_delivery/presentation/screens/deliveries/deliveries_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String landing = '/landing';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String editProfile = '/edit_profile';
  static const String trackOrders = '/track_orders';
  static const String orderHistory = '/order_history_screen';
  static const String location = '/location';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String reportIssue = '/report_issue';
  static const String orders = '/orders';
  static const String deliveries = '/deliveries';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => SplashScreen(),
      landing: (context) => LandingScreen(),
      login: (context) => LoginScreen(), // Ahora usa la clase correctamente
      home: (context) => HomeScreen(),
      profile: (context) => ProfileScreen(),
      editProfile: (context) => EditProfileScreen(),
      trackOrders: (context) => TrackOrdersScreen(),
      orderHistory: (context) => OrderHistoryScreen(),
      location: (context) => LocationScreen(),
      settings: (context) => SettingsScreen(),
      notifications: (context) => NotificationsScreen(),
      reportIssue: (context) => ReportIssueScreen(),
      orders: (context) => OrdersScreen(),
      deliveries: (context) => DeliveriesScreen(),
    };
  }
}
