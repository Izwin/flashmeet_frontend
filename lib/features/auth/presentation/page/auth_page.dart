import 'package:flash_meet_frontend/core/router/app_router.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_bloc.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_event.dart';
import 'package:flash_meet_frontend/features/auth/presentation/bloc/user_state.dart';
import 'package:flash_meet_frontend/features/main/presentation/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  static const String route = '/auth';

  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == UserStatus.error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${state.errorMessage}')));
        }
        if (state.status == UserStatus.success) {
          context.go(MainPage.route);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FlashMeet',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'By DevVibe Youtube',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(.7)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Center(
                      child: Image.asset('assets/images/intro.png'),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Find events. Meet people. Stay connected!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontSize: 32, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Discover exciting events nearby, connect with new people, and create your own meetups!',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<UserBloc>().add(SignInWithGoogleEvent());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary))),
                          label: Text('Sign in with Google'),
                          icon: SvgPicture.asset('assets/images/google.svg'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
