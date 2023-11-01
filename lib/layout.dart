import 'package:flutter/material.dart';
import 'package:groce_zone_admin/components/app_colors.dart';
import 'package:groce_zone_admin/components/small_screen.dart';
import 'package:groce_zone_admin/pages/dashboard/dashboard_screen.dart';

import 'components/large_screen.dart';
import 'components/side_menu.dart';
import 'components/top_nav_bar.dart';
import 'helpers/responsive.dart';


class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar:  topNavigationBar(context, scaffoldKey),
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 50),
        child: ResponsiveWidget(
            largeScreen:  DashBoardScreen(),
            smallScreen: SmallScreen(),
        ),
      ),
    );
  }
}
