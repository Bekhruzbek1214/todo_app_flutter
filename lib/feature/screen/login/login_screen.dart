import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/local/shared_preference.dart';
import 'package:todo_app/extensions/custom_navigation.dart';
import 'package:todo_app/extensions/custom_toast.dart';
import 'package:todo_app/feature/bloc/login/login_bloc.dart';
import 'package:todo_app/feature/bloc/login/login_state.dart';
import 'package:todo_app/feature/screen/register/register_screen.dart';
import 'package:todo_app/feature/screen/tab_bar/tab_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final email = TextEditingController();
   final password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>LoginBloc(SharedPreferenceHelper()),
      child: Scaffold(
        backgroundColor: const Color(0xFFEDEDED),
        appBar: AppBar(
          backgroundColor: const Color(0xFFEDEDED),
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.white38,
              shape: BoxShape.circle,
            ),

          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                SizedBox(
                    height: 285,
                    width: double.infinity,
                    child: Image.asset('assets/sign_in.png')
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Enter your Email address',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  obscureText: true,
                ),

                const SizedBox(height: 10),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                BlocConsumer<LoginBloc, LoginState>(
                    builder: (context, state){
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor : const Color(0xFF5A877D),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Handle sign-up button press
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account ?",
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: GestureDetector(
                                    onTap: (){
                                      // Navigator.of(context).push(
                                      //     MaterialPageRoute(builder:
                                      //         (context) => const RegisterScreen()
                                      //     ));
                                      CustomNavigation.pushReplacement(context, RegisterScreen());
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF5A877D),
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ],
                      );

                    },
                    listener: (context, state){
                      if(state is LoginFailure){
                        CustomToast.show(
                          state.message,
                          backgroundColor:  Colors.red,
                          textColor: Colors.white
                        );
                      }else if(state is LoginSuccess){
                        CustomToast.show(
                            "Login Success",
                            backgroundColor: Colors.green,
                            textColor: Colors.white
                        );
                        CustomNavigation.pushAndRemoveUntil(
                            context,
                            const TabBarScreen());
                      }
                    }),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
void main() {
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}


