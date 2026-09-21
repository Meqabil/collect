class IncreasesOrDecreasesModel {
  final String id;
  final String debtId;
  final String debtorId;
  final double installment;
  final String type;
  final String note;
  final DateTime createdAt;
  IncreasesOrDecreasesModel({
    required this.id,
    required this.debtId,
    required this.debtorId,
    required this.installment,
    required this.type,
    required this.note,
    required this.createdAt,
  });


  factory IncreasesOrDecreasesModel.fromJson(Map<String,dynamic> json){
    return IncreasesOrDecreasesModel(
      id: json['id'] ?? '',
      debtId: json['debt_id'] ?? '',
      debtorId: json['debtor_id'] ?? '',
      installment: json['installment'] ?? 0,
      type: json['type'] ?? '',
      note: json['note'] ?? '',
      createdAt: json['created_at'].toDate() ?? DateTime.now(),
    );
  }
}
