import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../controller/debts/debts_controller.dart';
import '../../widgets/debts/debt_filter_chip.dart';

class DebtOptionsView extends StatelessWidget {
  const DebtOptionsView({super.key});
  @override
  Widget build(BuildContext context) {
    DebtsControllerImpl controller = Get.find();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GetBuilder<DebtsControllerImpl>(
        builder: (context) {
          return Row(
            children: [
              DebtFilterChip(
                title: "all".tr,
                icon: Icons.list,
                selected: controller.option == DebtOptions.all,
                color: Colors.green,
                onTap: (){
                  controller.getDebtsForAll("all");
                  controller.updateOption(DebtOptions.all);
                },
              ),
              DebtFilterChip(
                title: 'due_today'.tr,
                icon: Icons.date_range_sharp,
                selected: controller.option == DebtOptions.dueToday,
                color: Colors.orange,
                onTap: (){
                  controller.getDebtsForAll("due");
                  controller.updateOption(DebtOptions.dueToday);
                },
              ),
              DebtFilterChip(
                title: "late".tr,
                icon: Icons.access_time_rounded,
                selected: controller.option == DebtOptions.late,
                color: Colors.red,
                onTap: (){
                  controller.getDebtsForAll("late");
                  controller.updateOption(DebtOptions.late);
                },
              ),
              DebtFilterChip(
                title: 'nearly_deserved'.tr,
                icon: Icons.calendar_today,
                selected: controller.option == DebtOptions.nearly,
                color: Colors.grey,
                onTap: (){
                  controller.getDebtsForAll("nearly");
                  controller.updateOption(DebtOptions.nearly);
                },
              ),
              DebtFilterChip(
                title: "payed".tr,
                icon: Icons.check_circle_outline,
                selected: controller.option == DebtOptions.payed,
                color: Colors.blue,
                onTap: (){
                  controller.getDebtsForAll("payed");
                  controller.updateOption(DebtOptions.payed);
                },

              ),
            ],
          );
        }
      ),
    );
  }
}
