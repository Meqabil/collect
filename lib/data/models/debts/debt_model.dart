class DebtModel {
  String id;
  String debtorId;
  String debtStatus;
  String type;
  double debt;
  double openingMoney;
  double changedMoney;
  int numOfInstallments;
  double valueOfFirstInstallment;
  DateTime createdAt;
  DateTime nextDate;
  DateTime lastPayed;

  DebtModel({
    required this.id,
    required this.debtorId,
    required this.debtStatus,
    required this.type,
    required this.debt,
    required this.openingMoney,
    required this.changedMoney,
    required this.numOfInstallments,
    required this.valueOfFirstInstallment,
    required this.createdAt,
    required this.nextDate,
    required this.lastPayed
  });

  factory DebtModel.fromJson(Map<String,dynamic> json){
    return DebtModel(
      id: json['id'],
      debtorId: json['debtor_id'],
      debtStatus: json['debt_status'],
      type: json['type'],
      debt: json['debt'],
      openingMoney: json['opening_money'],
      changedMoney: json['changed_money'].toDouble() ?? 0,
      numOfInstallments: json['num_of_installments'],
      valueOfFirstInstallment: json['value_of_first_installment'],
      createdAt: json['created_at'].toDate() ?? DateTime.now(),
      nextDate: json['next_date'].toDate() ?? DateTime.now(),
      lastPayed: json['last_payed'].toDate() ?? DateTime.now()
    );
  }
}

