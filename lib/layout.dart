import 'package:flutter/material.dart';

import 'components/top_nav_bar.dart';


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
      // body: ResponsiveWidget(
      //     largeScreen: const LargeScreen(),
      //     smallScreen: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16),
      //       child: localNavigator(),
      //     )
      // ),
    );
  }
}
