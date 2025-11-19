sealed class ResultFB<T> {}

class SuccessFB<T> extends ResultFB<T> {
  SuccessFB({this.data});
  T? data;
}

class ErrorFB<T> extends ResultFB<T> {
  ErrorFB({required this.messageError});
  String messageError;
}

ResultFB get getUser {
  return SuccessFB();
}
