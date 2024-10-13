

class ResDTO<T> {
  final int code;
  final String message;
  final T? data;

  ResDTO({
    required this.code,
    required this.message,
    this.data,
  });
}
