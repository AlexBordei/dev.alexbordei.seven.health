import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<dynamic> properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => [properties];
}

// Server failures
class ServerFailure extends Failure {
  const ServerFailure([List<dynamic> properties = const <dynamic>[]])
      : super(properties);
}

// Cache failures
class CacheFailure extends Failure {
  const CacheFailure([List<dynamic> properties = const <dynamic>[]])
      : super(properties);
}

// Network failures
class NetworkFailure extends Failure {
  const NetworkFailure([List<dynamic> properties = const <dynamic>[]])
      : super(properties);
}

// Authentication failures
class AuthenticationFailure extends Failure {
  final String message;

  AuthenticationFailure(this.message) : super([message]);

  @override
  List<Object?> get props => [message];
}

// Validation failures
class ValidationFailure extends Failure {
  final Map<String, String> errors;

  ValidationFailure(this.errors) : super([errors]);

  @override
  List<Object?> get props => [errors];
}
