class UserTypeEntity {
  String? idUser;
  String type;

  UserTypeEntity({
    this.idUser,
    this.type = '',
  });

  UserTypeEntity copy({
    String? idUser,
    String? type,
  }) =>
      UserTypeEntity(
        idUser: idUser ?? this.idUser,
        type: type ?? this.type,
      );
}
