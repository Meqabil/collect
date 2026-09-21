class InstallmentModel {
  final String id;
  final String debtId;
  final String debtorId;
  final double installment;
  final String meanOfContact;
  final String method;
  final String note;
  final DateTime createdAt;
  final DateTime nextDate;
  InstallmentModel({
    required this.id,
    required this.debtId,
    required this.debtorId,
    required this.installment,
    required this.meanOfContact,
    required this.method,
    required this.note,
    required this.createdAt,
    required this.nextDate,
  });

  factory InstallmentModel.fromJson(Map<String,dynamic> json){
    return InstallmentModel(
      id: json['id'] ?? '',
      debtId: json['debt_id'] ?? '',
      debtorId: json['debtor_id'] ?? '',
      installment: json['installment'] ?? 0,
      meanOfContact: json['mean_of_contact'] ?? '',
      method: json['method'] ?? '',
      note: json['note'] ?? '',
      createdAt: json['created_at'].toDate() ?? DateTime.now(),
      nextDate: json['next_date'].toDate() ?? DateTime.now()
    );
  }

}