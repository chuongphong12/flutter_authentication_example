import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttter_authentication/repository/auth_repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories _authRepositories;

  AuthBloc({required AuthRepositories authRepositories})
      : _authRepositories = authRepositories,
        super(AuthUnInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final bool hasToken = await _authRepositories.hasToken();
    if (hasToken) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnAuthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _authRepositories.persistToken(event.token);
    emit(AuthAuthenticated());
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _authRepositories.deleteToken();
    emit(AuthUnAuthenticated());
  }
}
