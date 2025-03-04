import 'package:firebase_core/firebase_core.dart';
import 'package:flash_meet_frontend/core/get_it/get_it.dart';
import 'package:flash_meet_frontend/core/router/app_router.dart';
import 'package:flash_meet_frontend/core/theme/app_theme.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_bloc.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_event.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_state.dart';
import 'package:flash_meet_frontend/features/main/presentation/bloc/main_bloc.dart';
import 'package:flash_meet_frontend/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/presentation/page/auth_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
        getIt<UserBloc>()
          ..add(GetUserEvent()),
      ),
      BlocProvider(
        create: (context) => getIt<MainBloc>(),
      ),
    ],
    child: MaterialApp.router(
      theme: AppTheme.getTheme(),
      builder: (context, widget) {
        return BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state.status == UserStatus.error ||
                state.status == UserStatus.logout) {
              AppRouter.router.go(AuthPage.route);
            }
          },
          child: Center(child: widget),
        );
      },
      routerConfig: AppRouter.router,
    ),
  ));
}
