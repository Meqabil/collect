import 'package:collect/controller/debts/debts_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/view/widgets/debts/summary_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    DebtsControllerImpl controller = DebtsControllerImpl();
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("reports".tr,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
        child: Column(
          children: [
            Container(
              width: appSizes.width,
              height: appSizes.height / 4.8,
              margin: EdgeInsets.all(appSizes.height * 0.010),
              child: FutureBuilder(
                future: controller.getDebtsSummary(),
                builder: (context, snap) {
                  return GetBuilder<DebtsControllerImpl>(
                    builder: (con) {
                      if(snap.connectionState == ConnectionState.done) {
                        final summary = snap.data ?? [0, 0, 0, 0];
                        return GridView(
                          gridDelegate: isPortrait ?
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,crossAxisSpacing: 3,mainAxisSpacing: 3,childAspectRatio: 2.4) :
                            SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,crossAxisSpacing: 3,mainAxisSpacing: 3,childAspectRatio: 2.4),
                          children: [
                            SummaryCard(title: "total_debts".tr, value: summary[0].toInt().toString(), icon: Icons.wallet, color: Colors.blue),
                            SummaryCard(title: "collected".tr, value: summary[4].toInt().toString(), icon: Icons.check_box, color: Colors.green),
                            SummaryCard(title: "late".tr, value: summary[2].toInt().toString(), icon: Icons.timer, color: Colors.red),
                            SummaryCard(title: "rest".tr, value: (summary[0] - summary[4]).toInt().toString(), icon: Icons.real_estate_agent_sharp, color: Colors.orange)
                          ],
                        );
                      }
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,crossAxisSpacing: 3,mainAxisSpacing: 3,childAspectRatio: 2.4),
                        children: [
                          SummaryCard(title: "total_debts".tr, value: "0", icon: Icons.wallet, color: Colors.blue),
                          SummaryCard(title: "collected".tr, value: "0", icon: Icons.check_box, color: Colors.green),
                          SummaryCard(title: "late".tr, value: "0", icon: Icons.timer, color: Colors.red),
                          SummaryCard(title: "rest".tr, value: "0", icon: Icons.real_estate_agent_sharp, color: Colors.orange)
                        ],
                      );

                    }
                  );
                }
              ),
            ),
            appSizes.height > 500 ? Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: appSizes.height * 0.01),
                padding:  EdgeInsets.symmetric(horizontal: appSizes.height * 0.015,vertical: appSizes.height * 0.012),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow:  [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 35,
                      spreadRadius: 0,
                      offset: const Offset(0, 8),
                    ),
                    BoxShadow(
                      color: Colors.black.withAlpha(12),
                      blurRadius: 15,
                      spreadRadius: -2,
                      offset: const Offset(0, 2),
                    ),
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("general_statistics".tr,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(height: appSizes.height * 0.012,),
                    Row(
                      spacing: 10,
                      children: [
                        Spacer(),
                        Container(
                          width: appSizes.height * 0.018,
                          height: appSizes.height * 0.018,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle
                          ),
                        ),
                        Text("${'collected'.tr}   "),
                        Container(
                          width: appSizes.height * 0.018,
                          height: appSizes.height * 0.018,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                          ),
                        ),
                        Text("${'late'.tr}    "),
                        Container(
                          width: appSizes.height * 0.018,
                          height: appSizes.height * 0.018,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle
                          ),
                        ),
                        Text("${'rest'.tr} "),
                        Spacer()
                      ],
                    ),
                    SizedBox(
                      height: appSizes.height / 3,
                      child: FutureBuilder(
                        future: controller.getDebtsSummary(),
                        builder: (context, snap) {
                          if(snap.connectionState == ConnectionState.done) {
                            final summary = snap.data ?? [0, 0, 0, 0];
                            return PieChart(
                              PieChartData(
                                centerSpaceRadius: 45,
                                sectionsSpace: 3,
                                sections: [
                                  PieChartSectionData(
                                    value: ((summary[0] - summary[4]) /summary[0]) * 100.0,
                                    title: '${((summary[0] - summary[4]) /summary[0] * 100).toStringAsFixed(0)}%',
                                    radius: 55,
                                    color: Colors.orange,
                                    titleStyle: TextStyle(
                                      fontSize: appSizes.height * 0.015,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (summary[4] /summary[0]) * 100.0,
                                    title: '${(summary[4] /summary[0] * 100).toStringAsFixed(0)}%',
                                    radius: 55,
                                    color: Colors.green,
                                    titleStyle: TextStyle(
                                      fontSize: appSizes.height * 0.014,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (summary[2] /summary[0]) * 100.0,
                                    title: '${(summary[2] /summary[0] * 100).toStringAsFixed(0)}%',
                                    radius: 55,
                                    color: Colors.red,
                                    titleStyle: TextStyle(
                                      fontSize: appSizes.height * 0.01,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return PieChart(
                            PieChartData(
                              centerSpaceRadius: 45,
                              sectionsSpace: 3,
                              sections: [
                                PieChartSectionData(
                                  value: 30,
                                  title: '30%',
                                  radius: 55,
                                  color: Colors.orange,
                                  titleStyle: TextStyle(
                                    fontSize: appSizes.height * 0.015,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                PieChartSectionData(
                                  value: 30,
                                  title: '30%',
                                  radius: 55,
                                  color: Colors.orange,
                                  titleStyle:  TextStyle(
                                    fontSize: appSizes.height * 0.015,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                PieChartSectionData(
                                  value: 30,
                                  title: '30%',
                                  radius: 55,
                                  color: Colors.green,
                                  titleStyle: TextStyle(
                                    fontSize: appSizes.height * 0.015,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                PieChartSectionData(
                                  value: 40,
                                  title: '40%',
                                  radius: 55,
                                  color: Colors.red,
                                  titleStyle: TextStyle(
                                    fontSize: appSizes.height * 0.015,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                    ),
                    Spacer(),
                    Row(
                      spacing: 5,
                      children: [
                        Icon(Icons.info,color: Colors.red,),
                        SizedBox(width: isNotPhone ? appSizes.width * .8 : appSizes.width - 100,child: Text('down_report_screen_text'.tr,overflow: TextOverflow.fade,)),
                      ],
                    )
                  ],
                ),
              ),
            ) : Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  Icon(Icons.warning,color: Colors.orange,size: appSizes.width * 0.03,),
                  Text('There is no enough space to show chart',textScaler: TextScaler.linear(1.5),style: TextStyle(fontSize: appSizes.width * 0.02),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
