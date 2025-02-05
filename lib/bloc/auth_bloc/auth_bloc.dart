import "package:bloc/bloc.dart";
import "package:meta/meta.dart";

import '../../repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_handleLogin);
    on<SignUpEvent>(_handleSignUp);
  }

  Future<void> _handleLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await _authRepository.login(event.email, event.password);
      emit(AuthSuccess(token));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _handleSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await _authRepository.signUp(
        event.email,
        event.password,
        event.name,
      );
      emit(AuthSuccess(token));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
