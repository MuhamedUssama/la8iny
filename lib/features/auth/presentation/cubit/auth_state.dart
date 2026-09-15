import 'package:la8iny/features/auth/data/models/user_model.dart';

enum AuthStatus { initial, loading, loggedIn, loggedOut, failure }

extension AuthStatusX on AuthState {
  bool get isInitial => status == AuthStatus.initial;
  bool get isLoading => status == AuthStatus.loading;
  bool get isLoggedIn => status == AuthStatus.loggedIn;
  bool get isLoggedOut => status == AuthStatus.loggedOut;
  bool get isError => status == AuthStatus.failure;
}

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({AuthStatus? status, User? user, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() =>
      'AuthState(state: $status, user: $user, message: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.status == status &&
        other.user == user &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ user.hashCode ^ errorMessage.hashCode;
}
