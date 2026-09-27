// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_sources/auth_local_data_source.dart'
    as _i606;
import '../../features/auth/data/data_sources/auth_remote_data_base.dart'
    as _i144;
import '../../features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i25;
import '../../features/auth/data/repo/auth_repo_impl.dart' as _i984;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/auth/presentation/repo/auth_repo.dart' as _i307;
import '../../features/tabs/chat_tab/data/data_sources/chat_data_source.dart'
    as _i587;
import '../../features/tabs/chat_tab/data/data_sources/chat_data_source_impl.dart'
    as _i269;
import '../../features/tabs/chat_tab/data/repository/chat_repo.dart' as _i356;
import '../../features/tabs/chat_tab/data/repository/chat_repo_impl.dart'
    as _i323;
import '../../features/tabs/chat_tab/presentation/controllers/chat_cubit/chat_cubit.dart'
    as _i76;
import '../../features/tabs/chat_tab/presentation/controllers/search_bloc/search_bloc.dart'
    as _i819;
import 'service_locator.dart' as _i105;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => firebaseModule.firebaseFirestore,
    );
    gh.lazySingleton<_i606.AuthLocalDataSource>(
      () => _i606.AuthLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i144.AuthRemoteDataBase>(
      () => _i144.AuthRemoteDatabaseImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i587.ChatDataSource>(
      () => _i269.ChatDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i25.AuthRemoteDataSource>(
      () => _i25.AuthRemoteDataSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i356.ChatRepo>(
      () => _i323.ChatRepoImpl(gh<_i587.ChatDataSource>()),
    );
    gh.factory<_i76.ChatCubit>(() => _i76.ChatCubit(gh<_i356.ChatRepo>()));
    gh.factory<_i819.SearchBloc>(() => _i819.SearchBloc(gh<_i356.ChatRepo>()));
    gh.lazySingleton<_i307.AuthRepo>(
      () => _i984.AuthRepoImpl(
        gh<_i25.AuthRemoteDataSource>(),
        gh<_i606.AuthLocalDataSource>(),
        gh<_i144.AuthRemoteDataBase>(),
      ),
    );
    gh.factory<_i117.AuthCubit>(() => _i117.AuthCubit(gh<_i307.AuthRepo>()));
    return this;
  }
}

class _$FirebaseModule extends _i105.FirebaseModule {}
