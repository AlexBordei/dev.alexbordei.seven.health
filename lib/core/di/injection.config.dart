// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/sign_in_use_case.dart' as _i362;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../network/network_client.dart' as _i30;
import 'register_module.dart' as _i291;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i519.Client>(() => registerModule.httpClient);
  gh.lazySingleton<_i787.AuthRepository>(() => _i153.AuthRepositoryImpl());
  gh.factory<_i362.SignInUseCase>(
      () => _i362.SignInUseCase(gh<_i787.AuthRepository>()));
  gh.lazySingleton<_i30.NetworkClient>(
      () => _i30.NetworkClientImpl(client: gh<_i519.Client>()));
  gh.factory<_i797.AuthBloc>(() => _i797.AuthBloc(gh<_i362.SignInUseCase>()));
  return getIt;
}

class _$RegisterModule extends _i291.RegisterModule {}
