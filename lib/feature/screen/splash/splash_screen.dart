import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/local/shared_preference.dart';
import 'package:todo_app/feature/bloc/splash/splash_bloc.dart';
import 'package:todo_app/feature/bloc/splash/splash_event.dart';
import 'package:todo_app/feature/screen/get_started/get_started_screen.dart';
import 'package:todo_app/feature/screen/tab_bar/tab_bar.dart';
import '../../bloc/splash/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(SharedPreferenceHelper())..add(CheckVerificationStatus()),
      child: Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TabBarScreen()),
              );
            }
            else if (state is SplashUnauthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const GetStartedScreen()),
              );
            }
          },
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(child: Image.asset('assets/flutter_icon.png')),
                  const Text(
                    'Do It On Time',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
