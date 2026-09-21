import 'package:collect/controller/settings/help_center_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/view/widgets/settings/help_expand_data.dart';
import 'package:collect/view/widgets/shared/main_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  HelpCenterControllerImpl controller = Get.put(HelpCenterControllerImpl());
  @override
  void initState() {
    controller.loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text("help_center".tr),
      ),
      body: Container(
        width: appSizes.width,
        height: appSizes.height,
        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
        child: Column(
          children: [
            MainSearchBar(
              hint: "search".tr,
              onChanged: (v){
                controller.filterData(v);
              },
            ),
            SizedBox(height: 15,),
            Expanded(
              child: GetBuilder<HelpCenterControllerImpl>(
                  builder: (context) {
                    return ListView.builder(
                      itemCount: controller.filteredData.length,
                      itemBuilder: (context,idx){
                        return HelpExpandData(item: controller.filteredData[idx]);
                      },
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
