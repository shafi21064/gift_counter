class GifterModel {
  int? id;
  String? name;
  String? gender;
  String? giftType;
  String? amount = 'not found';
  String? giftName = 'not found';
  String? date;

  GifterModel({
    this.id,
    this.name,
    this.gender,
    this.giftType,
    this.amount,
    this.giftName,
    this.date
  });

  GifterModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    giftType = json['giftType'];
    amount = json['amount'];
    giftName = json['giftName'];
    date = json['date'];
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'giftType': giftType,
      'amount': amount,
      'giftName': giftName,
      'date': date,
    };
  }
}