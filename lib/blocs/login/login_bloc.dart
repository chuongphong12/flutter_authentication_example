import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttter_authentication/blocs/auth/auth_bloc.dart';
import 'package:fluttter_authentication/repository/auth_repositories.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepositories _authRepositories;
  final AuthBloc _authBloc;
  LoginBloc(
      {required AuthRepositories authRepositories, required AuthBloc authBloc})
      : _authRepositories = authRepositories,
        _authBloc = authBloc,
        super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginExecuted);
  }

  void _onLoginExecuted(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      final token = await _authRepositories.login(event.email, event.password);
      emit(LoginSuccess(token: token));
      _authBloc.add(LoggedIn(token: token));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
