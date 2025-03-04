import 'dart:async';

import 'package:flash_meet_frontend/features/auth/domain/repository/auth_repository.dart';
import 'package:flash_meet_frontend/features/auth/domain/repository/user_repository.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_event.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  UserBloc({required this.authRepository,required this.userRepository}) : super(UserState.initial()) {
    on<SignInWithGoogleEvent>(onSignInWithGoogleEvent);
    on<GetUserEvent>(onGetUserEvent);
    on<SignOutEvent>(onSignOutEvent);
    on<EditProfileEvent>(onEditProfileEvent);
  }

  Future onSignInWithGoogleEvent(
      SignInWithGoogleEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var result = await authRepository.signInWithGoogle();
    result.fold((l) {
      emit(state.copyWith(status: UserStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(status: UserStatus.success, userEntity: r));
    });
  }

  Future onGetUserEvent(GetUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var result = await userRepository.getUser();
    result.fold((l) {
      emit(state.copyWith(status: UserStatus.error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(status: UserStatus.success, userEntity: r));
    });
  }

  Future onSignOutEvent(SignOutEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var result = await authRepository.logOut();
    result.fold((l){
      emit(state.copyWith(status: UserStatus.error,errorMessage: l.message));
    }, (r){
      emit(state.copyWith(status: UserStatus.logout));
    });
  }

  Future onEditProfileEvent(EditProfileEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var result = await userRepository.editUser(name: event.name, bio: event.bio,avatar: event.avatar);
    result.fold((l){
      emit(state.copyWith(status: UserStatus.error,errorMessage: l.message));
    }, (r){
      emit(state.copyWith(status: UserStatus.successfullyEditedProfile));
      add(GetUserEvent());
    });
  }
}
