
import 'package:collect/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../controller/debts/debts_controller.dart';
import '../../widgets/debts/debt_square_money.dart';

class MoneyBoardView extends StatelessWidget {
  const MoneyBoardView({super.key});
  @override
  Widget build(BuildContext context) {
    DebtsControllerImpl controller = Get.find();
    controller.getDebtsSummary();
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
        return Container(
        width: appSizes.width,
        height: !isPortrait && !isNotPhone ? appSizes.height / 4.2 : appSizes.height / 5,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
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
      child: GetBuilder<DebtsControllerImpl>(
        builder: (context) {
          return FutureBuilder<List>(
            future: controller.getDebtsSummary(),
            builder: (context, snap) {
              if(snap.connectionState == ConnectionState.done){
                final summary = snap.data ?? [0,0,0,0];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DebtSquareMoney(
                      title: 'total_debts'.tr,
                      value: summary[0].toInt().toString(),
                      icon: Icons.check_circle_outline,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: appSizes.width / 100,
                      height: appSizes.height / 15,
                      child: VerticalDivider(
                        thickness: 0.4,
                      ),
                    ),
                    DebtSquareMoney(
                      title: 'due_today'.tr,
                      value: summary[1].toInt().toString(),
                      icon: Icons.calendar_month_outlined,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: appSizes.width / 100,
                      height: appSizes.height / 15,
                      child: VerticalDivider(
                        thickness: 0.4,
                      ),
                    ),
                    DebtSquareMoney(
                      title: 'late'.tr,
                      value: summary[2].toInt().toString(),
                      icon: Icons.access_time_rounded,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: appSizes.width / 100,
                      height: appSizes.height / 15,
                      child: VerticalDivider(
                        thickness: 0.4,
                      ),
                    ),
                    DebtSquareMoney(
                      title: 'has_collected'.tr,
                      value: summary[3].toInt().toString(),
                      icon: Icons.wallet,
                      color: Color(0xff1b8554),
                    ),
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DebtSquareMoney(
                    title: "total_debts".tr,
                    value: "0",
                    icon: Icons.check_circle_outline,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 5,
                    height: 80,
                    child: VerticalDivider(
                      thickness: 0.4,
                    ),
                  ),
                  DebtSquareMoney(
                    title: 'due_today'.tr,
                    value: "0",
                    icon: Icons.calendar_month_outlined,
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: 5,
                    height: 80,
                    child: VerticalDivider(
                      thickness: 0.4,
                    ),
                  ),
                  DebtSquareMoney(
                    title: "late".tr,
                    value: "0",
                    icon: Icons.access_time_rounded,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5,
                    height: 80,
                    child: VerticalDivider(
                      thickness: 0.4,
                    ),
                  ),
                  DebtSquareMoney(
                    title: 'has_collected'.tr,
                    value: "0",
                    icon: Icons.wallet,
                    color: Color(0xff1b8554),
                  ),
                ],
              );
            }
          );
        }
      ),
    );
  }
}
