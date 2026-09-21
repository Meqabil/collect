class DelayModel {
  final String id;
  final String debtId;
  final String debtorId;
  final String debt;
  final String meanOfContact;
  final String note;
  final String reason;
  final DateTime createdAt;
  final DateTime delayedTo;
  final DateTime delayedFrom;
  DelayModel({
    required this.id,
    required this.debtId,
    required this.debtorId,
    required this.debt,
    required this.meanOfContact,
    required this.note,
    required this.reason,
    required this.createdAt,
    required this.delayedTo,
    required this.delayedFrom,
  });

  factory DelayModel.fromJson(Map<String,dynamic> json){
    return DelayModel(
        id: json['id'] ?? '',
        debtId: json['debt_id'] ?? '',
        debtorId: json['debtor_id'] ?? '',
        debt: json['debt'] ?? "0",
        meanOfContact: json['mean_of_contact'] ?? '',
        note: json['note'] ?? '',
        reason: json['reason'] ?? '',
        createdAt: json['created_at'].toDate() ?? DateTime.now(),
        delayedTo: json['delayed_to'].toDate() ?? DateTime.now(),
        delayedFrom: json['delayed_from'].toDate() ?? DateTime.now()
    );
  }

}