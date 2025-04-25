import 'package:crm_client/feature/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.surname,
    required super.birthdate,
    required super.address,
    required super.phone,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map["name"],
      surname: map["surname"],
      birthdate: map["birthdate"],
      address: map["address"],
      phone: map["phone"],
    );
  }
}
