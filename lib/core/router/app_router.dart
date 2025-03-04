import 'package:flash_meet_frontend/features/auth/presentation/page/auth_page.dart';
import 'package:flash_meet_frontend/features/chat/presentation/page/chat_page.dart';
import 'package:flash_meet_frontend/features/create_meet/presentation/page/create_meet_page.dart';
import 'package:flash_meet_frontend/features/create_meet/presentation/page/location_picker_page.dart';
import 'package:flash_meet_frontend/features/main/presentation/page/main_page.dart';
import 'package:flash_meet_frontend/features/meet/presentation/page/meet_page.dart';
import 'package:flash_meet_frontend/features/profile/presentation/page/edit_profile_page.dart';
import 'package:flash_meet_frontend/features/profile/presentation/page/profile_page.dart';
import 'package:flash_meet_frontend/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter{
  static var router = GoRouter(initialLocation: SplashPage.route,routes: [
    GoRoute(path: SplashPage.route,builder: (context,state){
      return SplashPage();
    }),
    GoRoute(path: AuthPage.route,builder: (context,state){
      return AuthPage();
    }),
    GoRoute(path: MainPage.route,builder: (context,state){
      return MainPage();
    }),
    GoRoute(path: ProfilePage.route,builder: (context,state){
      return ProfilePage();
    }),
    GoRoute(path: EditProfilePage.route,builder: (context,state){
      return EditProfilePage();
    }),
    GoRoute(path: CreateMeetPage.route,builder: (context,state){
      return CreateMeetPage();
    }),
    GoRoute(path: LocationPickerPage.route,builder: (context,state){
      return LocationPickerPage();
    }),
    GoRoute(path: '/meet/:id',builder: (context,state){
      return MeetPage(meetId: state.pathParameters['id'] ?? '');
    }),
    GoRoute(path: '/chat/:id',builder: (context,state){
      return ChatPage(meetId: state.pathParameters['id'] ?? '',);
    })
  ]);
}