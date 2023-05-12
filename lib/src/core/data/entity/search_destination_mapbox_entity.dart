class SearchDestinationMapBox {
  double lat;
  double lng;
  String text;

  SearchDestinationMapBox({
    this.lat = 0,
    this.lng = 0,
    this.text = '',
  });

  SearchDestinationMapBox copy({
    double? lat,
    double? lng,
    String? text,
  }) =>
      SearchDestinationMapBox(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        text: text ?? this.text,
      );
}
