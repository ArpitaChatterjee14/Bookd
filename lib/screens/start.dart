import 'package:bookd/screens/login.dart';
import 'package:bookd/screens/register.dart';
import 'package:bookd/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() {
    return _StartScreen();
  }
}

class _StartScreen extends State<StartScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            children: [
              TweenAnimationBuilder(
                child: Image.asset('assets/images/logo.png', width: 120),
                builder: (context, value, child) {
                  return Opacity(opacity: value, child: child);
                },
                duration: Duration(milliseconds: 5000),
                tween: Tween<double>(begin: 0, end: 1),
              ),
              LottieBuilder.asset(
                'assets/lottie/Bookd.json',
                controller: _controller,
                onLoaded: (composition) {
                  _controller.duration = composition.duration;
                  _controller.repeat();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ButtonConfig(
                      buttonVal: 'Login',
                      nav: () async {
                        // AssetsAudioPlayer.newPlayer().open(
                        //   Audio("assets/audio/tap.wav"),
                        //   autoStart: true,
                        // );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginForm(),
                          ),
                        );
                      },
                      h: 50.0,
                      w: double.infinity,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ButtonConfig(
                      buttonVal: 'Register',
                      nav: () async {
                        // AssetsAudioPlayer.newPlayer().open(
                        //   Audio("assets/audio/tap.wav"),
                        //   autoStart: true,
                        // );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RegisterForm(),
                          ),
                        );
                      },
                      h: 50.0,
                      w: double.infinity,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
