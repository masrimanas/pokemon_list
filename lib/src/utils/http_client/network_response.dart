import 'package:equatable/equatable.dart';

sealed class NetworkResponse<R, E extends Exception> {
  const NetworkResponse();
}

final class ResponseSuccess<R, E extends Exception>
    extends NetworkResponse<R, E> with EquatableMixin {
  const ResponseSuccess(this.response);
  final R response;

  @override
  List<Object?> get props => [response];
}

final class ResponseFailure<R, E extends Exception>
    extends NetworkResponse<R, E> with EquatableMixin {
  const ResponseFailure(this.exception);
  final E exception;

  @override
  List<Object?> get props => [exception];
}
