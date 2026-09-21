
import 'package:collect/core/errors/app_exception.dart';
import 'package:collect/core/routes/app_routes.dart';
import 'package:collect/data/models/debtors/debtor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/datasource/debtors/debtor_datasource.dart';
import '../../view/widgets/errors/error_dialog.dart';

abstract class DebtorController extends GetxController{
  Future<void> showAllDebtors();
  Future<void> addDebtor({required String id,required String name,String phoneNumber,String address,String note});
  Future<void> updateDebtor({required String debtorId,required String name,required String phoneNumber,required String address,required String note});
  Future<void> deleteDebtor(String debtorId);
  Future<DebtorModel> getDebtor(String id);
  void updateCategory(String cate);
  void searchDebtor(String name);
  void clear();

}

class DebtorControllerImpl extends DebtorController{
  PageController pageController = PageController();
  int currentStep = 0;
  final key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  RxList<DebtorModel> debtorsList = <DebtorModel>[].obs;
  List<DebtorModel> filteredList = <DebtorModel>[];
  final DebtorData data = DebtorData();
  String category = 'personal';


  @override
  Future<void> showAllDebtors() async{
    try{
      debtorsList.value = await data.getAllDebtors();
    } on DebtorException catch(e){
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
  void updateCategory(String cate) {
    try{
      category = cate;
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
  Future<void> addDebtor({required String id,required String name,String phoneNumber = '',String address = '',String note = ''}) async{
    try{
      data.addDebtor(id: id,name: name, category: category,address: address,phoneNumber: phoneNumber,note: note);
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
  Future<void> updateDebtor({required String debtorId, required String name,required String phoneNumber,required String address,required String note}) async{
    try{
      data.updateDebtor(debtorId: debtorId, name: name, note: note, address: address, phoneNumber: phoneNumber, category: category);
    } on DebtorException catch(e){
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
  getDebtor(String id){
    try{
      return data.getDebtor(id);
    } on DebtorException catch(e){
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
    return data.getDebtor(id);
  }

  @override
  void searchDebtor(String name) {
    try{
      filteredList = debtorsList.where((e) => e.name.toLowerCase().contains(name.toLowerCase())).toList();
    } on DebtorException catch(e){
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

  Future<void> deleteDebtor(String debtorId) async{
    try{
      data.deleteDebtor(debtorId);
    } on DebtorException catch(e){
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
  void clear() {
    notesController.clear();
    addressController.clear();
    phoneController.clear();
    nameController.clear();
    category = 'personal';
    update();
  }

  @override
  void onInit() {
    filteredList = debtorsList;
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }
}

