import 'package:bookd/screens/login.dart';
import 'package:bookd/screens/phone_verification.dart';
import 'package:bookd/screens/start.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:bookd/services/auth_services.dart';
import 'package:bookd/provider/login_data.dart';
import 'package:provider/provider.dart';

class Verified extends StatefulWidget {
  const Verified({super.key, required this.opt});
  final String opt;

  @override
  State<Verified> createState() => _Verified();
}

class _Verified extends State<Verified> with TickerProviderStateMixin {
  late AnimationController _controller;
  final AuthService authService = AuthService();

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
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Lottie.asset('assets/lottie/Anim8_.json', controller: _controller,
              onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward().whenComplete(
                () => widget.opt == 'dialog'
                    ? showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            children: [
                              Column(children: [
                                Text('Email Verified !'),
                                Text(
                                    'Do you wish to verify your phone as well ?'),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    ElevatedButton(
                                        onPressed: () async {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           const PhoneVerification()),
                                          // );
                                          http.Response phoneRes =
                                              await authService
                                                  .phoneVerification(
                                                      phone: user.phone);
                                          print(phoneRes.body);
                                          if (phoneRes.statusCode == 200) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PhoneVerification()),
                                            );
                                          }
                                        },
                                        child: Text('Continue')),
                                    SizedBox(width: 70),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginForm()),
                                          );
                                        },
                                        child: Text('Later')),
                                  ],
                                ),
                              ]),
                            ],
                          );
                        },
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginForm()),
                      ),
              );
          })
        ]),
      ),
    );
  }
}
