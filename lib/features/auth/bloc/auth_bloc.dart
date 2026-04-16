import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
    try {
      final isLoggedIn = await repository.checkLoggedIn();
      if (isLoggedIn) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      if (event.email.isEmpty || !event.email.contains('@')) {
        throw Exception('Invalid email address');
      }
      if (event.password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }
      await repository.login(event.email, event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignupRequested(SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      if (event.email.isEmpty || !event.email.contains('@')) {
        throw Exception('Invalid email address');
      }
      if (event.password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }
      await repository.signup(event.email, event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await repository.logout();
    emit(Unauthenticated());
  }
}
