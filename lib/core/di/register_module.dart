import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  // External dependencies
  @lazySingleton
  http.Client get httpClient => http.Client();
}
