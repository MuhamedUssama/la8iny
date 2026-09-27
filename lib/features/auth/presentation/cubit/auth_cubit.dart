import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:la8iny/features/auth/presentation/repo/auth_repo.dart';

import 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  AuthCubit(this._authRepo) : super(const AuthState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final user = await _authRepo.login(email: email, password: password);
      emit(state.copyWith(status: AuthStatus.loggedIn, user: user));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final user = await _authRepo.signUp(
        name: name,
        email: email,
        password: password,
      );
      emit(state.copyWith(status: AuthStatus.loggedIn, user: user));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> getUser() async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final user = await _authRepo.getUser();
      debugPrint('user: $user');
      emit(state.copyWith(status: .loggedIn, user: user));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> logout() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      await _authRepo.logout();

      emit(state.copyWith(status: AuthStatus.loggedOut));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
