class ResponseData<T> {
  final bool isOk;
  final String menssage;
  final T? data;

  ResponseData({
    required this.isOk,
    required this.menssage,
    this.data,
  });
}
