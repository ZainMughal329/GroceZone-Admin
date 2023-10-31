import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groce_zone_admin/components/text_widget.dart';
import 'package:groce_zone_admin/pages/dashboard/controller.dart';
import 'package:groce_zone_admin/pages/dashboard/widgets/revenue_info.dart';
import '../../../components/app_colors.dart';
import '../../../components/custom_text.dart';
import '../../../helpers/responsive.dart';
import 'bar_chart.dart';
import 'info_card.dart';

class DashBoardView extends StatelessWidget {
  DashBoardView({super.key});

  final con = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    con.fetchData();
    double width = MediaQuery
        .of(context)
        .size
        .width;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 25,vertical: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      con.refreshData();
                    },
                    child: Icon(Icons.refresh)),
              ),
            ),
            ResponsiveWidget.isLargeScreen(context)
                ? Obx(
                  () =>
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        InfoCard(
                          title: "Pending Orders",
                          value: con.state.pendingOrders.value.toString(),
                          onTap: () {},
                          topColor: Colors.orange,
                        ),
                        SizedBox(
                          width: width / 64,
                        ),
                        InfoCard(
                          title: "Shipped Orders",
                          value: con.state.shippedOrders.value.toString(),
                          onTap: () {},
                          topColor: Colors.yellow,
                        ),
                        SizedBox(
                          width: width / 64,
                        ),
                        InfoCard(
                          title: "Delivered Orders",
                          value: con.state.deliveredOrders.value.toString(),
                          onTap: () {},
                          topColor: Colors.green,
                        ),
                        SizedBox(
                          width: width / 64,
                        ),
                        InfoCard(
                          title: "Cancelled Orders",
                          value: con.state.cancelledOrders.value.toString(),
                          onTap: () {},
                          topColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
            )
                : Obx(
                  () =>
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            InfoCard(
                              title: "Pending Orders",
                              value: con.state.pendingOrders.value.toString(),
                              onTap: () {},
                              topColor: Colors.orange,
                            ),
                            SizedBox(
                              width: width / 64,
                            ),
                            InfoCard(
                              title: "Shipped Orders",
                              value: con.state.shippedOrders.value.toString(),
                              onTap: () {},
                              topColor: Colors.yellow,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: width / 64,
                        ),
                        Row(
                          children: [
                            InfoCard(
                              title: "Delivered Orders",
                              value:
                              con.state.deliveredOrders.value.toString(),
                              onTap: () {},
                              topColor: Colors.green,
                            ),
                            SizedBox(
                              width: width / 64,
                            ),
                            InfoCard(
                              title: "Cancelled Orders",
                              value:
                              con.state.cancelledOrders.value.toString(),
                              onTap: () {},
                              topColor: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            ),
            ResponsiveWidget.isLargeScreen(context)
                ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 20),
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 6),
                        color: lightGrey.withOpacity(.1),
                        blurRadius: 12)
                  ],
                  border: Border.all(color: lightGrey, width: .5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CustomText(
                            text: "Sales Chart",
                            size: 24,
                            weight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Container(
                              height: 200,
                              child: ResponsiveWidget.isSmallScreen(
                                  context)
                                  ? Container()
                                  : Obx(() =>
                                  Container(
                                    child: PieChart(
                                      PieChartData(
                                        sections: [
                                          PieChartSectionData(
                                            // value: double.parse(con.state.totalOrders.value.toString()),
                                            value: 10,
                                            color: Colors.blue,
                                            title: 'Total Orders : ' +
                                                con.state.totalOrders
                                                    .value
                                                    .toString(),
                                            titlePositionPercentageOffset:
                                            0.5,
                                            titleStyle: TextStyle(
                                                color: Colors.black,
                                                shadows: shadows
                                              // fontSize: 16,
                                            ),
                                          ),
                                          PieChartSectionData(
                                            value: double.parse(con
                                                .state
                                                .pendingOrders
                                                .value
                                                .toString()),
                                            color: Colors.orange,
                                            title:
                                            'Pending Orders : ' +
                                                con
                                                    .state
                                                    .pendingOrders
                                                    .value
                                                    .toString(),
                                            titlePositionPercentageOffset:
                                            1,
                                            titleStyle: TextStyle(
                                                color: Colors.black,
                                                shadows: shadows
                                              // fontSize: 16,
                                            ),
                                          ),
                                          PieChartSectionData(
                                            value: double.parse(con
                                                .state
                                                .deliveredOrders
                                                .value
                                                .toString()),
                                            color: Colors.green,
                                            title:
                                            'Delivered Orders : ' +
                                                con
                                                    .state
                                                    .deliveredOrders
                                                    .value
                                                    .toString(),
                                            titlePositionPercentageOffset:
                                            1,
                                            titleStyle: TextStyle(
                                                color: Colors.black,
                                                // fontSize: 10,
                                                shadows: shadows),
                                          ),
                                          PieChartSectionData(
                                            value: double.parse(con
                                                .state
                                                .shippedOrders
                                                .value
                                                .toString()),
                                            color: Colors.yellow,
                                            title:
                                            'Shipped Orders : ' +
                                                con
                                                    .state
                                                    .shippedOrders
                                                    .value
                                                    .toString(),
                                            titlePositionPercentageOffset:
                                            0.5,
                                            titleStyle: TextStyle(
                                                color: Colors.black,
                                                // fontSize: 16,
                                                shadows: shadows),
                                          ),
                                          PieChartSectionData(
                                            value: double.parse(con
                                                .state
                                                .cancelledOrders
                                                .value
                                                .toString()),
                                            color: Colors.red,
                                            title:
                                            'Cancelled Orders : ' +
                                                con
                                                    .state
                                                    .cancelledOrders
                                                    .value
                                                    .toString(),
                                            titlePositionPercentageOffset:
                                            1,
                                            titleStyle: TextStyle(
                                                color: Colors.black,
                                                // fontSize: 16,
                                                shadows: shadows),
                                          ),
                                        ],
                                        centerSpaceRadius: 80,
                                        sectionsSpace: 5,
                                        borderData: FlBorderData(
                                          show: true,
                                          border: Border.all(
                                              color: Colors.grey),
                                        ),
                                      ),
                                      swapAnimationDuration: Duration(
                                          seconds: 3), // Optional
                                      swapAnimationCurve:
                                      Curves.easeOutBack,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 120,
                      color: lightGrey,
                    ),
                    Expanded(
                      child: Obx((){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                RevenueInfo(
                                  title: "Today's revenue",
                                  amount: con
                                      .state.orderPricesForLastDay.value
                                      .toString(),
                                ),
                                RevenueInfo(
                                  title: "Last 7 days",
                                  amount: con.state
                                      .orderPricesForLastSevenDays.value
                                      .toString(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                RevenueInfo(
                                  title: "Last 30 days",
                                  amount: con
                                      .state.orderPricesForLastMonth.value
                                      .toString(),
                                ),
                                RevenueInfo(
                                  title: "Last 12 months",
                                  amount: con
                                      .state.orderPricesForLastYear.value
                                      .toString(),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 20),
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 6),
                        color: lightGrey.withOpacity(.1),
                        blurRadius: 12)
                  ],
                  border: Border.all(color: lightGrey, width: .5),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 260,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CustomText(
                            text: "Sales Chart",
                            size: 24,
                            weight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 600,
                            height: 200,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Container(
                                height: 200,
                                child: ResponsiveWidget.isSmallScreen(
                                    context)
                                    ? Container()
                                    : Obx(() =>
                                    Container(
                                      child: PieChart(
                                        PieChartData(
                                          sections: [
                                            PieChartSectionData(
                                              // value: double.parse(con.state.totalOrders.value.toString()),
                                              value: 10,
                                              color: Colors.blue,
                                              title:
                                              'Total Orders : ' +
                                                  con
                                                      .state
                                                      .totalOrders
                                                      .value
                                                      .toString(),
                                              titlePositionPercentageOffset:
                                              0.5,
                                              titleStyle: TextStyle(
                                                  color: Colors.black,
                                                  shadows: shadows
                                                // fontSize: 16,
                                              ),
                                            ),
                                            PieChartSectionData(
                                              value: double.parse(con
                                                  .state
                                                  .pendingOrders
                                                  .value
                                                  .toString()),
                                              color: Colors.orange,
                                              title:
                                              'Pending Orders : ' +
                                                  con
                                                      .state
                                                      .pendingOrders
                                                      .value
                                                      .toString(),
                                              titlePositionPercentageOffset:
                                              1,
                                              titleStyle: TextStyle(
                                                  color: Colors.black,
                                                  shadows: shadows
                                                // fontSize: 16,
                                              ),
                                            ),
                                            PieChartSectionData(
                                              value: double.parse(con
                                                  .state
                                                  .deliveredOrders
                                                  .value
                                                  .toString()),
                                              color: Colors.green,
                                              title: 'Delivered Orders : ' +
                                                  con
                                                      .state
                                                      .deliveredOrders
                                                      .value
                                                      .toString(),
                                              titlePositionPercentageOffset:
                                              1,
                                              titleStyle: TextStyle(
                                                  color: Colors.black,
                                                  // fontSize: 10,
                                                  shadows: shadows),
                                            ),
                                            PieChartSectionData(
                                              value: double.parse(con
                                                  .state
                                                  .shippedOrders
                                                  .value
                                                  .toString()),
                                              color: Colors.yellow,
                                              title:
                                              'Shipped Orders : ' +
                                                  con
                                                      .state
                                                      .shippedOrders
                                                      .value
                                                      .toString(),
                                              titlePositionPercentageOffset:
                                              0.5,
                                              titleStyle: TextStyle(
                                                  color: Colors.black,
                                                  // fontSize: 16,
                                                  shadows: shadows),
                                            ),
                                            PieChartSectionData(
                                              value: double.parse(con
                                                  .state
                                                  .cancelledOrders
                                                  .value
                                                  .toString()),
                                              color: Colors.red,
                                              title: 'Cancelled Orders : ' +
                                                  con
                                                      .state
                                                      .cancelledOrders
                                                      .value
                                                      .toString(),
                                              titlePositionPercentageOffset:
                                              1,
                                              titleStyle: TextStyle(
                                                  color: Colors.black,
                                                  // fontSize: 16,
                                                  shadows: shadows),
                                            ),
                                          ],
                                          centerSpaceRadius: 80,
                                          sectionsSpace: 5,
                                          borderData: FlBorderData(
                                            show: true,
                                            border: Border.all(
                                                color: Colors.grey),
                                          ),
                                        ),
                                        swapAnimationDuration:
                                        Duration(
                                            seconds:
                                            3), // Optional
                                        swapAnimationCurve:
                                        Curves.easeOutBack,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 1,
                      color: lightGrey,
                    ),
                    SizedBox(
                      height: 260,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              RevenueInfo(
                                title: "Today\'s revenue",
                                amount: con
                                    .state.orderPricesForLastDay.value
                                    .toString(),
                              ),
                              RevenueInfo(
                                title: "Last 7 days",
                                amount: con.state
                                    .orderPricesForLastSevenDays.value
                                    .toString(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              RevenueInfo(
                                title: "Last 30 days",
                                amount: con
                                    .state.orderPricesForLastMonth.value
                                    .toString(),
                              ),
                              RevenueInfo(
                                title: "Last 12 months",
                                amount: con
                                    .state.orderPricesForLastYear.value
                                    .toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('allOrders')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: active.withOpacity(.4), width: .5),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 6),
                              color: lightGrey.withOpacity(.1),
                              blurRadius: 12)
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: "Available Orders",
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: (56 * 7) + 40,
                            child: DataTable2(
                              columnSpacing: 12,
                              dataRowHeight: 56,
                              headingRowHeight: 40,
                              horizontalMargin: 12,
                              minWidth: 600,
                              columns: [
                                DataColumn2(
                                  label: CustomText(
                                    text: 'Order-Id',
                                    weight: FontWeight.bold,
                                    size: 16,
                                  ),

                                  size: ColumnSize.L,
                                ),
                                DataColumn(
                                  label: CustomText(
                                    text: 'Name',
                                    weight: FontWeight.bold,
                                    size: 16,
                                  ),
                                ),
                                DataColumn(
                                  label: CustomText(
                                    text: 'Price',
                                    weight: FontWeight.bold,
                                    size: 16,
                                  ),
                                ),
                                DataColumn(
                                    label: CustomText(
                                      text: 'Status',
                                      weight: FontWeight.bold,
                                      size: 16,
                                    ),
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                15,
                                    (index) =>
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          CustomText(
                                            text: snapshot
                                                .data!.docs[index]['orderId']
                                                .toString(),
                                            weight: FontWeight.bold,
                                            size: 16,
                                          ),
                                        ),
                                        DataCell(
                                          CustomText(
                                            text: snapshot.data!
                                                .docs[index]['name']
                                                .toString(),
                                          ),
                                        ),
                                        DataCell(
                                          CustomText(
                                            text: '₨ ' + snapshot
                                                .data!.docs[index]['orderPrice']
                                                .toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: snapshot.data!
                                                  .docs[index]['status']
                                                  .toString() ==
                                                  'shipped'
                                                  ? Colors.yellow.withOpacity(
                                                  0.3)
                                                  : snapshot.data!
                                                  .docs[index]['status']
                                                  .toString() ==
                                                  'cancelled'
                                                  ? Colors.red.withOpacity(0.3)
                                                  : snapshot
                                                  .data!
                                                  .docs[index]
                                              ['status']
                                                  .toString() ==
                                                  'pending'
                                                  ? Colors.green
                                                  .withOpacity(0.3)
                                                  : Colors.orange
                                                  .withOpacity(0.3),
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: snapshot.data!
                                                      .docs[index]['status']
                                                      .toString() ==
                                                      'shipped'
                                                      ? Colors.yellow
                                                      : snapshot
                                                      .data!
                                                      .docs[index]
                                                  ['status']
                                                      .toString() ==
                                                      'cancelled'
                                                      ? Colors.red
                                                      : snapshot
                                                      .data!
                                                      .docs[index]
                                                  ['status']
                                                      .toString() ==
                                                      'pending'
                                                      ? Colors.green
                                                      : Colors.orange,
                                                  width: 1),
                                            ),
                                            // padding: const EdgeInsets.symmetric(
                                            //     horizontal: 12, vertical: 6),
                                            child: Center(
                                              child: CustomText(
                                                text: snapshot
                                                    .data!.docs[index]['status']
                                                    .toString().capitalizeFirst.toString(),
                                                color:
                                                Colors.black.withOpacity(0.8),
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    print('Error');
                    return SizedBox();
                  }
                  return SizedBox();
                }),
            // InkWell(
            //   onTap: (){
            //     con.fetchDataAndCalculatePrices();
            //   },
            //   child: Container(
            //     height: 100,
            //     width: 100,
            //     color: Colors.black,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
