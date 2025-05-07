import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:sevenhealth/core/error/failures.dart';

abstract class NetworkClient {
  /// Makes a GET request to the specified [url].
  Future<Either<Failure, T>> get<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  });

  /// Makes a POST request to the specified [url].
  Future<Either<Failure, T>> post<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? fromJson,
  });

  /// Makes a PUT request to the specified [url].
  Future<Either<Failure, T>> put<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? fromJson,
  });

  /// Makes a DELETE request to the specified [url].
  Future<Either<Failure, T>> delete<T>(
    String url, {
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  });
}

@LazySingleton(as: NetworkClient)
class NetworkClientImpl implements NetworkClient {
  final http.Client client;

  NetworkClientImpl({required this.client});

  @override
  Future<Either<Failure, T>> get<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);
      final response = await client.get(uri, headers: headers);
      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return Left(NetworkFailure([e.toString()]));
    }
  }

  @override
  Future<Either<Failure, T>> post<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(url);
      final response = await client.post(
        uri,
        headers: {...?headers, 'Content-Type': 'application/json'},
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return Left(NetworkFailure([e.toString()]));
    }
  }

  @override
  Future<Either<Failure, T>> put<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(url);
      final response = await client.put(
        uri,
        headers: {...?headers, 'Content-Type': 'application/json'},
        body: body != null ? jsonEncode(body) : null,
      );
      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return Left(NetworkFailure([e.toString()]));
    }
  }

  @override
  Future<Either<Failure, T>> delete<T>(
    String url, {
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(url);
      final response = await client.delete(
        uri,
        headers: headers,
      );
      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return Left(NetworkFailure([e.toString()]));
    }
  }

  Either<Failure, T> _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Handle void or null cases
      if (fromJson == null) {
        try {
          final dynamic responseBody = jsonDecode(response.body);

          if (responseBody is T) {
            return Right(responseBody);
          } else {
            // Attempt a cast if possible
            return Right(responseBody as T);
          }
        } catch (e) {
          // For void returns or empty responses, this is for endpoints that don't return anything
          try {
            return Right(null as T);
          } catch (_) {
            return Left(ServerFailure([e.toString()]));
          }
        }
      } else {
        // Handle fromJson parsing
        try {
          final dynamic responseBody = jsonDecode(response.body);

          if (responseBody is Map<String, dynamic>) {
            final T data = fromJson(responseBody);
            return Right(data);
          } else {
            return Left(ServerFailure(['Response is not a JSON object']));
          }
        } catch (e) {
          return Left(ServerFailure([e.toString()]));
        }
      }
    } else {
      return Left(ServerFailure([response.statusCode, response.body]));
    }
  }
}
