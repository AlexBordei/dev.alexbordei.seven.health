import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sevenhealth/core/error/failures.dart';
import 'package:sevenhealth/features/auth/domain/entities/user.dart';
import 'package:sevenhealth/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  Future<Either<Failure, User>> call(SignInParams params) {
    return _authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
