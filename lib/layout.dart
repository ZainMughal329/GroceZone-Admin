import 'package:flutter/material.dart';
import 'package:groce_zone_admin/components/small_screen.dart';

import 'components/large_screen.dart';
import 'components/top_nav_bar.dart';
import 'helpers/responsive.dart';


class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar:  topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(
        // child: SideMenu(),
      ),
      body: ResponsiveWidget(
          largeScreen: const LargeScreen(),
          smallScreen: SmallScreen(),
      ),
    );
  }
}
