import 'package:crm_client/feature/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.surname,
    required super.birthdate,
    required super.phone,
    required super.sex,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String?,
      surname: map['surname'] as String?,
      sex: map['sex'] as bool?,
      phone: map['phone'] as String?,
      birthdate: map['birthDate'] as String?,
    );
  }
}
