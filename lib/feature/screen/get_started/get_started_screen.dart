import 'package:flutter/material.dart';
import 'package:todo_app/feature/screen/register/register_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/get_started_image.png'),
              const SizedBox(height: 20), // Add spacing between image and text
              const Text(
                'Get things done with TODO',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: const Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys '
                      'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 60, // Adjust the bottom value to control the vertical position
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()
                    )
                );
              },
              child: Container(

                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 55),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: const Color(0xFF5A877D),
                child: const Text(
                  'Get Started',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,

                ),

              ),
            ),

          ),
        ],
      ),
    );
  }
}
