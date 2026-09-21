import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/view/screens/debtors/edit_debtor_screen.dart';
import 'package:collect/view/screens/installments/debt_changes_screen.dart';
import 'package:collect/view/screens/installments/delays_for_debt_screen.dart';
import 'package:collect/view/screens/installments/installments_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../data/models/debtors/debtor_model.dart';
import '../../widgets/auth/tab_button.dart';
import '../../widgets/debtors/debtor_board.dart';

class DebtorScreen extends StatefulWidget {
  const DebtorScreen({super.key,required this.model});
  final DebtorModel model;

  @override
  State<DebtorScreen> createState() => _DebtorScreenState();
}

class _DebtorScreenState extends State<DebtorScreen> {
  PageController pageController = PageController();
  int pageNum = 0;
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text("debtor".tr,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Container(
        height: appSizes.height,
        width: appSizes.width,
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        child: Column(
          children: [
            GetBuilder<DebtorControllerImpl>(
              builder: (context) {
                return DebtorBoard(
                  name: widget.model.name,
                  phone: widget.model.phone,
                  address: widget.model.address,
                  type: widget.model.category,
                  note: widget.model.note,
                  hasEditButton: true,
                  onEditButtonPressed: (){
                    Get.to(() => EditDebtorScreen(model: widget.model,));
                  },
                );
              }
            ),
            SizedBox(height: 15,),
            Expanded(
              child: Container(
                width: appSizes.width,
                padding: EdgeInsets.symmetric(horizontal: appSizes.height * 0.012,vertical: appSizes.height * 0.01),
                decoration: BoxDecoration(
                  border: Border.all(width: .8,color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(11),
                  color: Theme.of(context).colorScheme.secondary,
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
                child: GetBuilder<DebtorControllerImpl>(
                  builder: (context) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TabButton(
                              title: "installments".tr,
                              width: (appSizes.width - 24) / 3 - 27,
                              showBorder: pageNum == 0,
                              onTap: (){
                                pageNum = 0;
                                pageController.animateToPage(
                                  0,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease
                                );
                                setState(() {});
                              }
                            ),

                            TabButton(
                              title: "delays".tr,
                              width: (appSizes.width - 24) / 3 - 27,
                              showBorder: pageNum == 1,
                              onTap: (){
                                pageNum = 1;
                                pageController.animateToPage(
                                  1,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease
                                );
                                setState(() {});
                              }
                            ),
                            TabButton(
                              title: "debt_changes".tr,
                              width: (appSizes.width - 24) / 3 - 27,
                              showBorder: pageNum == 2,
                              onTap: (){
                                pageNum = 2;
                                pageController.animateToPage(
                                  2,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease
                                );
                                setState(() {});
                              }
                            ),
                          ],
                        ),
                        SizedBox(height: 11,),
                        Expanded(
                          child: PageView(
                            controller: pageController,
                            onPageChanged: (page){
                              pageNum = page;
                              setState(() {});
                            },
                            children: [
                              InstallmentsScreen(debtorId: widget.model.id),
                              DelaysForDebtScreen(debtorId: widget.model.id),
                              DebtChangesScreen(debtorId: widget.model.id)
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
