import 'package:flutter/material.dart';
import 'package:windows_app_test/responsive_home_page.dart';

import '../custom_drawer/drawer_user_controller.dart';
import '../custom_drawer/home_drawer.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView = const ResponsiveHomePage();
  DrawerIndex drawerIndex = DrawerIndex.barcode;

  @override
  Widget build(BuildContext context) {
    return DrawerUserController(
      screenIndex: drawerIndex,
      drawerWidth: MediaQuery.of(context).size.width * 0.3,
      onDrawerCall: (DrawerIndex drawerIndexdata) {
        changeIndex(drawerIndexdata);
      },
      screenView: screenView,
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.home) {
        if (mounted) {
          setState(() {
            screenView = const ResponsiveHomePage();
          });
        }
      } else if (drawerIndex == DrawerIndex.barcode) {
        if (mounted) {
          setState(() {
            screenView = const ResponsiveHomePage();
          });
        }
      } else if (drawerIndex == DrawerIndex.feedback) {
        if (mounted) {
          setState(() {
            screenView = const ResponsiveHomePage();
          });
        }
      } else if (drawerIndex == DrawerIndex.invite) {
        if (mounted) {
          setState(() {
            screenView = const ResponsiveHomePage();
          });
        }
      } else if (drawerIndex == DrawerIndex.about) {
        if (mounted) {
          setState(() {
            screenView = const ResponsiveHomePage();
          });
        }
      }
    }
  }
}
