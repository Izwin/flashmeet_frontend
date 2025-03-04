import 'package:flash_meet_frontend/core/api/api_client.dart';
import 'package:flash_meet_frontend/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flash_meet_frontend/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:flash_meet_frontend/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flash_meet_frontend/features/auth/data/repository/user_repository_impl.dart';
import 'package:flash_meet_frontend/features/auth/domain/repository/auth_repository.dart';
import 'package:flash_meet_frontend/features/auth/domain/repository/user_repository.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_bloc.dart';
import 'package:flash_meet_frontend/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:flash_meet_frontend/features/chat/data/datasource/chat_socket_datasource.dart';
import 'package:flash_meet_frontend/features/chat/data/repository/chat_repository_impl.dart';
import 'package:flash_meet_frontend/features/chat/domain/repository/chat_repository.dart';
import 'package:flash_meet_frontend/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flash_meet_frontend/features/create_meet/presentation/bloc/create_meet_bloc.dart';
import 'package:flash_meet_frontend/features/create_meet/presentation/bloc/location_picker_bloc.dart';
import 'package:flash_meet_frontend/features/main/presentation/bloc/main_bloc.dart';
import 'package:flash_meet_frontend/features/meet/data/datasource/meet_remote_datasource.dart';
import 'package:flash_meet_frontend/features/meet/data/repository/meet_repository_impl.dart';
import 'package:flash_meet_frontend/features/meet/domain/repository/meet_repository.dart';
import 'package:flash_meet_frontend/features/meet/presentation/bloc/meet_bloc.dart';
import 'package:flash_meet_frontend/features/profile/presentation/bloc/last_meets_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

var getIt = GetIt.instance;

void setup() {
  registerGoogleSignIn();
  registerApiClient();
  registerDataSources();
  registerRepositories();
  registerBloc();
}

void registerGoogleSignIn() {
  getIt.registerSingleton(GoogleSignIn());
}

void registerApiClient() {
  getIt.registerSingleton(ApiClient());
}

void registerDataSources() {
  var dio = getIt<ApiClient>().getDio();
  var dioWithToken = getIt<ApiClient>().getDio(tokenInterceptor: true);
  getIt.registerSingleton(AuthRemoteDatasource(dio: dio));
  getIt.registerSingleton(UserRemoteDatasource(dio: dioWithToken));
  getIt.registerSingleton(MeetRemoteDatasource(dio: dioWithToken));
  getIt.registerSingleton(ChatRemoteDatasource(dio: dioWithToken));
  getIt.registerSingleton(ChatSocketDatasource());
}

void registerRepositories() {
  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(authRemoteDatasource: getIt(), googleSignIn: getIt()));
  getIt.registerSingleton<UserRepository>(
      UserRepositoryImpl(userRemoteDatasource: getIt()));
  getIt.registerSingleton<MeetRepository>(
      MeetRepositoryImpl(meetRemoteDatasource: getIt()));
  getIt.registerSingleton<ChatRepository>(ChatRepositoryImpl(
      chatRemoteDatasource: getIt(), chatSocketDatasource: getIt()));
}

void registerBloc() {
  getIt.registerFactory(
      () => UserBloc(authRepository: getIt(), userRepository: getIt()));
  getIt.registerFactory(() => LastMeetsBloc(meetRepository: getIt()));
  getIt.registerFactory(() => LocationPickerBloc());
  getIt.registerFactory(() => CreateMeetBloc(meetRepository: getIt()));
  getIt.registerFactory(() => MeetBloc(meetRepository: getIt()));
  getIt.registerFactory(() => MainBloc(meetRepository: getIt()));
  getIt.registerFactory(() => ChatBloc(chatRepository: getIt()));
}
