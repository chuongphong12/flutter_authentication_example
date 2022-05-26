part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthUnInitial extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnAuthenticated extends AuthState {}

class AuthLoading extends AuthState {}
