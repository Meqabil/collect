import 'package:collect/data/datasource/installments/installments_datasource.dart';
import 'package:collect/data/models/installments/delay_model.dart';
import 'package:collect/data/models/installments/increases_or_decreases_model.dart';
import 'package:collect/data/models/installments/installment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class InstallmentsController extends GetxController{
  void updateOption(String v);
  void updateMean(String v);
  void updatePayingMethod(String v);
  void changeDate(DateTime date);
  Future<void> delayInstallment({required String debtId,required String debtorId,required String debt,required String note,required String reason,required String meanOfContact,required DateTime delayedFrom,required DateTime delayedTo,});
  Future<void> payInstallment({required String debtId,required String debtorId,required double installment,required String note,required String method,required String meanOfContact,required DateTime nextDate});
  Future<void> settle({required String debtId, required String debtorId, required String note});
  Future<void> increaseOrDecreaseDebt({required String debtId,required String debtorId,required double installment,required String note,required bool increase});
  Future<List> getAllInstallments(String debtorId);
  Future<List> getAllDelaysForDebt(String debtorId);
  Future<List> getAllChangesInDebt(String debtorId);
  Future<void> deleteDelay(String id,String debtorId);
  Future<void> deleteInstallment(String installmentId,String debtorId);
  Future<void> deleteChangeInDebt(String id,String debtorId);
  Future<bool> hasSettled(String debtorId);
  void clear();

}

class InstallmentsControllerImpl extends InstallmentsController{
  GlobalKey<FormState> globalKey = GlobalKey();
  InstallmentsData data = InstallmentsData();
  TextEditingController notesController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  String option = "deny";
  String contact = "call";
  DateTime debtDate = DateTime.now();
  String payWay = "Cash";

  List<String> excuses = [
    "personal_reason",
    "waiting_money",
    "deny",
    "calc_not_accurate",
    "he_called_the_owner",
    "need_another_period",
    "unavailable_mean_of_paying"
  ];
  List<String> means = [
    "call",
    "whatsapp",
    "owner_order",
    "come_to_office"
  ];
  @override
  void updateOption(String v) {
    option = v;
    update();
  }
  @override
  void updateMean(String v) {
    contact = v;
    update();
  }
  @override
  void updatePayingMethod(String v) {
    payWay = v;
    update();
  }
  @override
  void changeDate(DateTime date) {
    debtDate = date;
    update();
  }

  @override
  Future<void> delayInstallment({required String debtId,required String debtorId,required String debt,required String note,required String reason,required String meanOfContact,required DateTime delayedFrom,required DateTime delayedTo,}) async {
    await data.delayInstallment(debtId: debtId, debtorId: debtorId, debt: debt, note: note, reason: reason, meanOfContact: meanOfContact, delayedFrom: delayedFrom, delayedTo: delayedTo);
    update();
  }

  @override
  Future<void> payInstallment({required String debtId, required String debtorId, required double installment, required String note, required String method, required String meanOfContact, required DateTime nextDate}) async {
    await data.payInstallment(debtId: debtId, debtorId: debtorId, installment: installment, note: note, method: method, meanOfContact: meanOfContact, nextDate: nextDate);
    update();
  }

  @override
  Future<void> settle({required String debtId, required String debtorId, required String note}) async{
    await data.settle(debtId: debtId, debtorId: debtorId, note: note);
  }


  @override
  Future<void> increaseOrDecreaseDebt({required String debtId,required String debtorId,required double installment,required String note,required bool increase}) async {
    await data.increaseOrDecreaseDebt(debtId: debtId, debtorId: debtorId, installment: installment, note: note, increase: increase);
    update();
  }

  @override
  Future<List<InstallmentModel>> getAllInstallments(String debtorId) async {
    return await data.getAllInstallments(debtorId);
  }

  @override
  Future<List<DelayModel>> getAllDelaysForDebt(String debtorId) async {
    return await data.getAllDelaysForDebt(debtorId);
  }

  @override
  Future<List<IncreasesOrDecreasesModel>> getAllChangesInDebt(String debtorId) async{
    return await data.getAllChangesInDebt(debtorId);
  }

  @override
  Future<void> deleteDelay(String id,String debtorId) async{
    await data.deleteDelay(id,debtorId);
    update();
  }

  @override
  Future<void> deleteInstallment(String installmentId,String debtorId) async{
    await data.deleteInstallment(installmentId,debtorId);
    update();
  }

  @override
  Future<void> deleteChangeInDebt(String id, String debtorId) async{
    await data.deleteChangeInDebt(id, debtorId);
    update();
  }

  @override
  Future<bool> hasSettled(String debtorId) async{
    return await data.hasSettled(debtorId);
  }

  @override
  void clear() {
    moneyController.clear();
    notesController.clear();
  }

  @override
  void dispose() {
    notesController.dispose();
    moneyController.dispose();
    super.dispose();
  }
}