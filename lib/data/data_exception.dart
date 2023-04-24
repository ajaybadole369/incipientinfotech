class AppException implements Exception {
  final _prefix;
  final _message;

  AppException([this._prefix, this._message]);

  String toString() {
    return '$_prefix  $_message';
  }
}

class InternetException extends AppException {
  InternetException([String? message]) : super('No Internet', message);
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException([String? message])
      : super('Request Time Out', message);
}

class ServerException extends AppException {
  ServerException([String? message]) : super('Server Not Respond', message);
}

class InvalidUrlException extends AppException {
  InvalidUrlException([String? message]) : super('Invalid Url', message);
}

class FetchDataCommunicationException extends AppException {
  FetchDataCommunicationException([String? message])
      : super('Error while communication', message);
}
