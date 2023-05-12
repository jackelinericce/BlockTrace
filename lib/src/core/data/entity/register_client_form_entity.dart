class RegisterClientFormEntity {
  String? id;
  String name;
  String lastName;
  String phone;
  String dni;
  String address;
  String email;
  String password;

  
  RegisterClientFormEntity({
    this.id,
    this.name = '',
    this.lastName = '',
    this.phone = '',
    this.dni = '',
    this.address = '',
    this.email = '',
    this.password = '',
  });

  RegisterClientFormEntity copy({
    String? id,
    String? name,
    String? lastName,
    String? phone,
    String? dni,
    String? address,
    String? email,
    String? password,
  }) =>
      RegisterClientFormEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        dni: dni ?? this.dni,
        address: address ?? this.address,
        email: email ?? this.email,
        password: password ?? this.password,
      );
  @override
  String toString() {
    return 'id:$id - n:$name - l:$lastName - p:$phone - d:$dni - a:$address -e:$email';
  }
}
