import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sevenhealth/core/error/failures.dart';
import 'package:sevenhealth/features/auth/data/models/user_model.dart';
import 'package:sevenhealth/features/auth/domain/entities/user.dart';
import 'package:sevenhealth/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  // Mock user for demo purposes
  final _mockUser = const UserModel(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    photoUrl: 'https://picsum.photos/200',
  );

  // Mock credentials for demo purposes
  final String _mockEmail = 'test@example.com';
  final String _mockPassword = 'password123';

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    if (email == _mockEmail && password == _mockPassword) {
      return Right(_mockUser);
    } else {
      return Left(
        AuthenticationFailure('Invalid email or password'),
      );
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    return Right(
      UserModel(
        id: '2',
        name: name,
        email: email,
        photoUrl: null,
      ),
    );
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return const Right(null);
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return Right(_mockUser);
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return const Right(false); // Always return false for demo purposes
  }
}
