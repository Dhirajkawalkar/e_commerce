/// Events for the Authentication Bloc.
/// 
/// These classes represent user actions or system triggers that affect
/// the authentication state of the application.
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

/// Event triggered to check if a user session already exists.
class CheckAuthStatus extends AuthEvent {}

/// Event triggered when the user attempts to log in.
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  const LoginRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

/// Event triggered when the user attempts to create a new account.
class SignupRequested extends AuthEvent {
  final String email;
  final String password;
  const SignupRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

/// Event triggered when the user wants to log out of the application.
class LogoutRequested extends AuthEvent {}
