class DebtorModel {
  String id;
  String userId;
  //int numOfAsks;
  String name;
  String phone;
  String address;
  String category;
  String lastStatus;
  String note;
  DateTime createdAt;

  DebtorModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.category,
    required this.note,
    required this.lastStatus,
    required this.createdAt,
  });


  factory DebtorModel.fromJson(Map<String,dynamic> json){
    return DebtorModel(
      id: json['id'] ?? '',
      userId: json['user_id'],
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      category: json['category'] ?? '',
      note: json['note'] ?? '',
      lastStatus: json['last_status'] ?? '',
      createdAt: json['created_at'].toDate() ?? DateTime.now(),
    );
  }


}

