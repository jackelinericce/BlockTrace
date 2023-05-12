class PerecederoEntity {
  String? id;
  String? img;
  String name;
  String description;

  PerecederoEntity({
    this.id,
    this.img = '',
    this.name = '',
    this.description = '',
  });

  PerecederoEntity copy({
    String? id,
    String? img,
    String? name,
    String? description,
  }) =>
      PerecederoEntity(
        id: id ?? this.id,
        img: img ?? this.img,
        name: name ?? this.name,
        description: description ?? this.description,
      );
}
