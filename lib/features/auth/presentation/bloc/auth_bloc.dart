import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sevenhealth/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:sevenhealth/features/auth/presentation/bloc/auth_event.dart';
import 'package:sevenhealth/features/auth/presentation/bloc/auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase _signInUseCase;

  AuthBloc(this._signInUseCase) : super(const AuthState()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<SignInEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.loading());

    // In a real app, check if user is authenticated here
    // For now, just emitting unauthenticated
    emit(state.unauthenticated());
  }

  Future<void> _onSignIn(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.loading());

    final result = await _signInUseCase(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(state.error(failure.toString())),
      (user) => emit(state.authenticated(user)),
    );
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.loading());

    // In a real app, perform sign out operation here
    emit(state.unauthenticated());
  }
}
