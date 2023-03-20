
class FireUser {
  String id;
  String fullName;
  String phone_number;
  String gender;
  String city;
  String car_model;
  String payment_method;
  String email;
  String password="";

  FireUser.name(this.id, this.fullName,this.gender, this.phone_number, this.city,
      this.car_model, this.payment_method, this.email,this.password);

  FireUser(
      {this.id="",
      this.fullName="",
      this.phone_number="",
      this.city="",
        this.gender="M",
      this.car_model="",
      this.payment_method="",
      this.password="",
      this.email=""});
  FireUser.fromMap(Map<String, dynamic> json)
      : id = json['user_id'],
        fullName = json['full_name'],
        phone_number = json['phone_number'],
        city = json['city'],
        gender = json['gender'],
        car_model = json['car_model'],
        payment_method = json['payment_method'],
        email = json['email'];


  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['phone_number'] = phone_number;
    data['city'] = city;
    data['car_model'] = car_model;
    data['payment_method'] = payment_method;
    data['email'] = email;
    data['gender'] = gender;
    return data;
  }
}
