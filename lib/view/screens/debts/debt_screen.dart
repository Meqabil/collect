import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/core/constants/app_sizes.dart';
import 'package:collect/core/security/encryption_service.dart';
import 'package:collect/data/models/debts/debt_model.dart';
import 'package:collect/view/screens/installments/paying_options_view.dart';
import 'package:collect/view/widgets/debts/debt_money_summary.dart';
import 'package:collect/view/widgets/debtors/debtor_board.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../core/constants/lists.dart';
import '../../../data/models/debtors/debtor_model.dart';


List data = [];
Future<String> getName(String name) async{
  await Future.delayed(Duration(seconds: 1));
  return name;
}
Future<String> getType(String type) async{
  return await CipherService.decrypt(type);
}
class DebtScreen extends StatelessWidget {
  const DebtScreen({super.key,required this.model});
  final DebtModel model;

  @override
  Widget build(BuildContext context) {
    DebtorControllerImpl controller = Get.find();
    AppSizes appSizes = AppSizes(context: context);
    bool isNotPhone = appSizes.width > 800 &&  appSizes.height > 600;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    String debtorName = '';
    String debtorPhone = '';
    data = [
      model.type,
      model.numOfInstallments,
      model.createdAt.toString().substring(0,10),
      model.nextDate.toString().substring(0,10),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("debt_details".tr,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: appSizes.width,
          height: isPortrait ? appSizes.height * .9 : appSizes.height * 1.2,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              isNotPhone ?
              Row(
                children: [
                  FutureBuilder(
                    future: controller.getDebtor(model.debtorId),
                    builder: (context, asyncSnapshot) {
                      if(asyncSnapshot.connectionState == ConnectionState.done){
                        DebtorModel? debtor = asyncSnapshot.data;
                        debtorName = debtor!.name;
                        debtorPhone = debtor.phone;
                        return DebtorBoard(
                          name: debtor.name,
                          phone: debtor.phone,
                          address: debtor.address,
                          type: debtor.category,
                        );
                      }
                      return DebtorBoard(
                        name: "Ahmed Mohammed",
                        phone: "0102545645",
                        address: "Cairo, Egypt",
                        type: "business",
                      );
                    }
                  ),
                  DebtMoneySummary(
                    debtTitle: "debt".tr,
                    debtValue: (model.openingMoney.toInt() + model.changedMoney.toInt()).toString(),
                    payedTitle: "payed".tr,
                    payedValue:( model.openingMoney.toInt() + model.changedMoney.toInt() - model.debt.toInt()).toString(),
                    restTitle: "rest".tr,
                    restValue: model.debt.toInt().toString(),
                  ),
                ],
              ) :
              Column(
                children: [
                  FutureBuilder<DebtorModel>(
                    future: controller.getDebtor(model.debtorId),
                    builder: (context, asyncSnapshot) {
                      if(asyncSnapshot.connectionState == ConnectionState.done){
                        DebtorModel? debtor = asyncSnapshot.data;
                        debtorName = debtor!.name;
                        debtorPhone = debtor.phone;
                        return DebtorBoard(
                          name: debtor.name,
                          phone: debtor.phone,
                          address: debtor.address,
                          type: debtor.category,
                        );
                      }
                      return DebtorBoard(
                        name: "Ahmed Mohammed",
                        phone: "0102545645",
                        address: "Cairo, Egypt",
                        type: "business",
                      );
                    }
                  ),
                  DebtMoneySummary(
                    debtTitle: "debt".tr,
                    debtValue: (model.openingMoney.toInt() + model.changedMoney.toInt()).toString(),
                    payedTitle: "payed".tr,
                    payedValue:( model.openingMoney.toInt() + model.changedMoney.toInt() - model.debt.toInt()).toString(),
                    restTitle: "rest".tr,
                    restValue: model.debt.toInt().toString(),
                  ),
                ],
              ),

              isNotPhone ? Container() : Container(
                width: appSizes.width,
                height: isPortrait ? appSizes.height * .35 : appSizes.height * .15 ,
                padding: EdgeInsets.symmetric(horizontal: appSizes.height * 0.01,vertical: 0),
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
                child: ListView.separated(
                  itemCount: titles.length,
                  shrinkWrap: true,
                  itemBuilder: (context,idx){
                    if(idx == 0){
                      return ListTile(
                        leading: Icon(icons[idx],color: Colors.green,),
                        title: Text(titles[idx].toString().tr),
                        trailing: FutureBuilder(
                          future: getType(data[idx]),
                          builder: (con,asy){
                            if(asy.connectionState == ConnectionState.done){
                              return Text(asy.data.toString().tr);
                            }
                            return Text('type'.tr);
                          }
                        ),

                      );
                    }
                    return ListTile(
                      leading: Icon(icons[idx],color: Colors.green,),
                      title: Text(titles[idx].toString().tr),
                      trailing: Text(data[idx].toString().tr),
                    );
                  },
                  separatorBuilder: (context,idx){
                    return Divider(height: 1,);
                  },
                ),
              ),
              isNotPhone ? Container() : SizedBox(height: appSizes.height * 0.01,),
              isNotPhone ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: appSizes.width / 2 - 20,
                    height: appSizes.height / 3,
                    padding: EdgeInsets.symmetric(horizontal: appSizes.height * 0.01,vertical: 0),
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
                    child: ListView.separated(
                      itemCount: titles.length,
                      shrinkWrap: true,
                      itemBuilder: (context,idx){
                        return ListTile(
                          leading: Icon(icons[idx],color: Colors.green,),
                          title: Text(titles[idx].toString().tr),
                          trailing: Text(data[idx].toString().tr),
                        );
                      },
                      separatorBuilder: (context,idx){
                        return Divider(height: 1,);
                      },
                    ),
                  ),
                  Spacer(),
                  FutureBuilder(
                    future: getName(debtorName),
                    builder: (context,async){
                      return PayingOptionsView(model: model, debtorName: debtorName, phoneNumber: debtorPhone,);
                    }
                  )
                ],
              ) : Container(),

              isNotPhone ? Container() : FutureBuilder(
                  future: getName(debtorName),
                  builder: (context,async){
                    return PayingOptionsView(model: model, debtorName: debtorName, phoneNumber: debtorPhone,);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
