class RegisterTransportFormEntity {
  String? id;
  String name;
  String lastName;
  String ruc;
  String address;
  String number;
  String licenseNumber;
  String categoryLicense;
  String email;
  String password;

  RegisterTransportFormEntity({
    this.id,
    this.name = '',
    this.lastName = '',
    this.ruc = '',
    this.address = '',
    this.number = '',
    this.licenseNumber = 'Q3614',
    this.categoryLicense = 'A III',
    this.email = '',
    this.password = '',
  });

  @override
  String toString() {
    // TODO: implement toString
    return 'n:$name l:$lastName cat:$categoryLicense';
  }

  RegisterTransportFormEntity copy({
    String? id,
    String? name,
    String? lastName,
    String? ruc,
    String? address,
    String? number,
    String? licenseNumber,
    String? categoryLicense,
    String? email,
    String? password,
  }) =>
      RegisterTransportFormEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        ruc: ruc ?? this.ruc,
        address: address ?? this.address,
        number: number ?? this.number,
        licenseNumber: licenseNumber ?? this.licenseNumber,
        categoryLicense: categoryLicense ?? this.categoryLicense,
        email: email ?? this.email,
        password: password ?? this.password,
      );
  // validateNameForm() {}
}
