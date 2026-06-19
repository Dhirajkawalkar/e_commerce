/// States for the Authentication Bloc.
/// 
/// These classes represent the various states of the user's authentication
/// session, such as loading, authenticated, or unauthenticated.
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

/// Initial state before any authentication check has been performed.
class AuthInitial extends AuthState {}

/// State indicating that an authentication operation (login/signup) is in progress.
class AuthLoading extends AuthState {}

/// State indicating that the user is successfully authenticated.
class Authenticated extends AuthState {
  /// The email of the authenticated user.
  final String email;
  const Authenticated(this.email);
  @override
  List<Object?> get props => [email];
}

/// State indicating that the user is not logged in.
class Unauthenticated extends AuthState {}

/// State indicating that an error occurred during authentication.
class AuthError extends AuthState {
  /// The error message to be displayed.
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}
