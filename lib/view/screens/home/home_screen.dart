import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/controller/home/home_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/view/screens/debtors/add_debtor_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/home/custom_button_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControllerImpl controller = Get.put(HomeControllerImpl());
    DebtorControllerImpl debtorController = Get.put(DebtorControllerImpl());
    AppSizes appSizes = AppSizes(context: context);
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    return Scaffold(
      bottomNavigationBar: isNotPhone ? null : BottomAppBar(
        color: Theme.of(context).colorScheme.secondary,
        shadowColor: Colors.black,
        elevation: 12,
        height: MediaQuery.of(context).orientation == Orientation.landscape ? appSizes.height / 5 : appSizes.height / 10,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: GetBuilder<HomeControllerImpl>(
          builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  controller.pages.length,
                      (index) => CustomButtonAppBar(
                    text: controller.navTexts[index].toString().tr,
                    icon: controller.navIcons[index],
                    activeColor: index == controller.page ? AppColors.mainAppColor : Colors.grey,
                    onTap: (){
                      controller.changePage(index);
                    },
                  ),
                )
              ],
            );
          }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isNotPhone ? null : FloatingActionButton(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
          onPressed: (){
            debtorController.clear();
            Get.to(() => AddDebtorScreen());
          },
          child: Icon(Icons.add,color: Colors.white,)
      ),
      body: GetBuilder<HomeControllerImpl>(
        builder: (context) {
          return Row(
            children: [
              isNotPhone ? NavigationRail(
                onDestinationSelected: (v){
                  controller.changePage(v);
                },
                destinations:  [
                  ...List.generate(
                     controller.pages.length,
                     (index) => NavigationRailDestination(
                        icon: Icon(controller.navIcons[index],color: index == controller.page ? AppColors.mainAppColor : Colors.grey,),
                        label: Text(controller.navTexts[index].toString().tr),
                      )
                  )
                ],
                trailing: Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: FloatingActionButton(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
                          onPressed: (){
                            debtorController.clear();
                            Get.to(() => AddDebtorScreen());
                          },
                          child: Icon(Icons.add,color: Colors.white,)
                      ),
                    ),
                  ),
                ),
                selectedIndex: controller.page,

              ) : Container(),
              Expanded(
                child: controller.pages[controller.page]
              )
            ],
          );
        }
      ),
    );
  }
}
