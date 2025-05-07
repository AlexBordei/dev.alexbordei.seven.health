import 'package:dartz/dartz.dart';
import 'package:sevenhealth/core/error/failures.dart';
import 'package:sevenhealth/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  /// Sign in with email and password
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  /// Sign out the current user
  Future<Either<Failure, void>> signOut();

  /// Get the current user
  Future<Either<Failure, User?>> getCurrentUser();

  /// Check if user is authenticated
  Future<Either<Failure, bool>> isAuthenticated();
}
