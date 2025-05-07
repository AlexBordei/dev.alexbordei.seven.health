import 'package:equatable/equatable.dart';
import 'package:sevenhealth/features/auth/domain/entities/user.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get isLoading => status == AuthStatus.loading;
  bool get hasError => status == AuthStatus.error;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  AuthState initial() {
    return const AuthState(status: AuthStatus.initial);
  }

  AuthState loading() {
    return copyWith(status: AuthStatus.loading);
  }

  AuthState authenticated(User user) {
    return copyWith(
      status: AuthStatus.authenticated,
      user: user,
      errorMessage: null,
    );
  }

  AuthState unauthenticated() {
    return copyWith(
      status: AuthStatus.unauthenticated,
      user: null,
      errorMessage: null,
    );
  }

  AuthState error(String message) {
    return copyWith(
      status: AuthStatus.error,
      errorMessage: message,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
