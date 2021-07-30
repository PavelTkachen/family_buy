class Response {
  final int? status;
  final ResponseBodyInterface body;

  Response({required this.status, required this.body});
}

abstract class ResponseBodyInterface {
  final body;
  ResponseBodyInterface({this.body});
  dynamic getBody();
  String? getError();
}

class ResponseSuccess implements ResponseBodyInterface {
  final body;
  ResponseSuccess({this.body});

  @override
  getBody() => body;

  @override
  String? getError() => null;
}

class ResponseFailure implements ResponseBodyInterface {
  final body;
  final error;
  ResponseFailure({this.body, this.error});

  @override
  getBody() => body;

  @override
  String getError() => this.error;
}
