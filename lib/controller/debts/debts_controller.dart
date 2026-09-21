import 'package:collect/data/datasource/debts/debts_datasource.dart';
import 'package:collect/data/models/debts/debt_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/errors/app_exception.dart';
import '../../core/routes/app_routes.dart';
import '../../view/widgets/errors/error_dialog.dart';
enum DebtOptions{
  all,
  dueToday,
  late,
  nearly,
  payed
}
abstract class DebtsController extends GetxController{
  void updateOption(DebtOptions op);
  Future<void> getDebtsForAll(String condition);
  Future<DebtModel> getDebt(String debtorId);
  Future<void> choseNextDate(DateTime date);
  Future<void> updateType(String type);
  Future<void> addDebt({required String debtorId,required double totalDebt,int numOfInstallments = 0,double valueOfFirstOfInstallment = 0,});
  Future<void> deleteDebt(String debtId);
  Future<List> getDebtsSummary();
  void clear();
}

class DebtsControllerImpl extends DebtsController{
  TextEditingController totalDebtController = TextEditingController();
  TextEditingController numOfInstallmentsController = TextEditingController();
  TextEditingController valueOfInstallmentController = TextEditingController();
  DebtOptions option = DebtOptions.all;
  DebtsData data = DebtsData();
  RxList<DebtModel> debtsList = <DebtModel>[].obs;
  RxBool isLoading = false.obs;
  DateTime nextDate = DateTime.now();
  String type = 'one_time';
  @override
  void updateOption(DebtOptions op){
    option = op;
    update();
  }

  @override
  choseNextDate(DateTime date) async {
    nextDate = date;
    update();
  }
  @override

  @override
  updateType(String t)async{
    type = t;
    update();
  }

  getDebtsForAll(String condition) async{
    try{
      debtsList.value = await data.getDebtsStateAll(condition);
    }on DebtException catch(e){
      Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          content: ErrorDialog(message: e.message)
      );
    } on NoInternetException {
      Get.toNamed(AppRoutes.noInternetConnection);
    } catch (e){
      Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          content: ErrorDialog(message: e.toString())
      );
    }
  }

  @override
  addDebt({required String debtorId,required double totalDebt,int numOfInstallments = 0,double valueOfFirstOfInstallment = 0,})async {
    try{
      data.addDebt(debtorId: debtorId, totalDebt: totalDebt, type: type, nextDate: nextDate,numOfInstallments: numOfInstallments,valueOfFirstOfInstallment: valueOfFirstOfInstallment);
    }on DebtorException catch(e){
      print("e ===>>> $e debt ");
      print("===================\n=========\n===\n==========");
      Get.defaultDialog(
          title: 'Debt',
          titleStyle: TextStyle(fontSize: 0),
          content: ErrorDialog(message: e.message)
      );
    } on NoInternetException {
      Get.toNamed(AppRoutes.noInternetConnection);
    } catch (e){
      Get.defaultDialog(
        title: 'Debt',
        titleStyle: TextStyle(fontSize: 0),
        content: ErrorDialog(message: e.toString())
      );
    }
    update();
  }
  @override
  Future<DebtModel> getDebt(String debtorId) async {
    return await data.getDebt(debtorId);
  }

  @override
  getDebtsSummary() async{
    return data.getDebtsSummary();
  }


  @override
  Future<void> deleteDebt(String debtId) async {
    try{
      data.deleteDebt(debtId);
    }on DebtorException catch(e){
      Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          content: ErrorDialog(message: e.message)
      );
    } on NoInternetException {
      Get.toNamed(AppRoutes.noInternetConnection);
    } catch (e){
      Get.defaultDialog(
          title: '',
          titleStyle: TextStyle(fontSize: 0),
          content: ErrorDialog(message: e.toString())
      );
    }
    update();
  }

  @override
  void clear() {
    totalDebtController.clear();
    numOfInstallmentsController.clear();
    valueOfInstallmentController.clear();
    type = 'one_time';
    update();
  }


  @override
  void onInit() {
    //getDebtsForAll("all");
    super.onInit();
  }
  @override
  void dispose() {
    totalDebtController.dispose();
    valueOfInstallmentController.dispose();
    numOfInstallmentsController.dispose();
    super.dispose();
  }


}
