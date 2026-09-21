import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/constants/assets/app_images.dart';
import 'package:collect/core/theme/app_colors.dart';
import 'package:collect/view/screens/debtors/debtor_screen.dart';
import 'package:collect/view/widgets/debtors/debtor_item.dart';
import 'package:collect/view/widgets/shared/main_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DebtorsScreen extends StatelessWidget {
  const DebtorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    DebtorControllerImpl controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("debtors".tr,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: AppColors.mainAppColor,
        onRefresh: () async{
          controller.showAllDebtors();
        },
        child: Container(
          width: appSizes.width,
          height: appSizes.height,
          padding: EdgeInsets.symmetric(horizontal: 11,vertical: 1),
          child: Column(
            spacing: appSizes.height * 0.01,
            children: [
              MainSearchBar(
                hint: 'search_name'.tr,
                onChanged: (v){
                  controller.searchDebtor(v);
                },
              ),
              GetBuilder<DebtorControllerImpl>(
                builder: (context) {
                  return Expanded(
                    child: FutureBuilder(
                      future: controller.showAllDebtors(),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (asyncSnapshot.hasError) {
                          return Center(
                            child: Text('Error: ${asyncSnapshot.error}'),
                          );
                        }

                        if (asyncSnapshot.connectionState == ConnectionState.done) {
                          if (controller.filteredList.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  isPortrait || (!isPortrait && appSizes.height > 600) ? Image.asset(
                                      width: appSizes.width / 2.5,
                                      AppImages.noDebtors
                                  ) : Container(),
                                  Text('no_debtors_added_yet'.tr,style: TextStyle(fontSize: isPortrait ? appSizes.height * 0.016 : appSizes.width * 0.016,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            );
                          }else{
                            // Finally data loaded
                            return ListView.builder(
                              itemCount: controller.filteredList.length,
                              itemBuilder: (context,idx){
                                final type = controller.filteredList[idx].category;
                                return DebtorItem(
                                  debtorId: controller.filteredList[idx].id,
                                  clientName: controller.filteredList[idx].name,
                                  type: type,
                                  onTap: (){
                                    Get.to(() => DebtorScreen(model: controller.filteredList[idx],));
                                  },
                                );
                              },
                            );
                          }
                        }
                        return Center(child: CircularProgressIndicator(color: AppColors.mainAppColor,),);
                      }
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
